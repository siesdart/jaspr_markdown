import 'dart:mirrors';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_markdown/src/ast.dart' as md;
import 'package:markdown/markdown.dart' as md show Element, Text;
import 'package:markdown/markdown.dart' hide Element, Text;

/// Represents a Markdown document.
class Markdown extends StatelessComponent {
  /// Instantiates a Markdown component with [markdown] document and
  /// [blockSyntaxes].
  const Markdown({required this.markdown, this.blockSyntaxes, super.key});

  /// Markdown document.
  final String markdown;

  /// Block syntaxes for the Markdown rendering.
  final Iterable<BlockSyntax>? blockSyntaxes;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield* _buildMarkdown(
      Document(
        blockSyntaxes: blockSyntaxes,
        extensionSet: ExtensionSet.gitHubWeb,
      ).parse(markdown),
    );
  }
}

Iterable<Component> _buildMarkdown(Iterable<Node> nodes) sync* {
  for (final node in nodes) {
    if (node is md.Text) {
      yield raw(node.text);
    } else if (node is md.Component) {
      yield reflectClass(node.type)
          .newInstance(node.constructorName, [], _buildNamedArguments(node))
          .reflectee as Component;
    } else if (node is md.Element) {
      if (node.tag == '_') {
        yield* _buildMarkdown(node.children!);
      } else {
        yield DomComponent(
          tag: node.tag,
          id: node.generatedId,
          attributes: node.attributes,
          children: node.children != null
              ? _buildMarkdown(node.children!).toList()
              : null,
        );
      }
    }
  }
}

Map<Symbol, dynamic> _buildNamedArguments(md.Component component) {
  final constructor =
      reflectClass(component.type).declarations.values.firstWhere(
            (e) =>
                e is MethodMirror &&
                e.isConstructor &&
                e.constructorName == component.constructorName,
          ) as MethodMirror;
  final namedArguments = component.namedArguments
    ..removeWhere(
      (key, value) => !constructor.parameters.any((e) => e.simpleName == key),
    );

  for (final parameter in constructor.parameters) {
    if (parameter.type.reflectedType == bool) {
      namedArguments[parameter.simpleName] =
          namedArguments.containsKey(parameter.simpleName);
    } else if (parameter.type.isSubtypeOf(reflectType(num))) {
      namedArguments[parameter.simpleName] =
          reflectClass(parameter.type.reflectedType).invoke(
        #parse,
        [namedArguments[parameter.simpleName]],
      ).reflectee;
    }
  }

  if (component.children != null &&
      component.children!.isNotEmpty &&
      constructor.parameters.any(
        (e) =>
            e.simpleName == #children &&
            e.type.isSubtypeOf(reflectType(Iterable<Component>)),
      )) {
    namedArguments.putIfAbsent(
      #children,
      () => _buildMarkdown(component.children!).toList(),
    );
  }

  return namedArguments;
}
