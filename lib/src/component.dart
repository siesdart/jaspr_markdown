import 'dart:mirrors';

import 'package:jaspr/jaspr.dart' hide Document;
import 'package:jaspr_markdown/src/ast.dart' as md;
import 'package:markdown/markdown.dart' as md show Element, Text;
import 'package:markdown/markdown.dart';

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
  Component build(BuildContext context) {
    return Component.fragment(_buildMarkdown(
      Document(
        blockSyntaxes: blockSyntaxes,
        extensionSet: ExtensionSet.gitHubWeb,
      ).parse(markdown),
    ));
  }
}

List<Component> _buildMarkdown(Iterable<Node> nodes) => nodes
    .map(
      (node) => switch (node) {
        md.Text _ => raw(node.text),
        md.Component _ => reflectClass(node.type)
            .newInstance(node.constructorName, [], _buildNamedArguments(node))
            .reflectee as Component,
        md.Element _ => Component.element(
            tag: node.tag,
            id: node.generatedId,
            attributes: node.attributes,
            children: node.children != null
                ? _buildMarkdown(node.children!).toList()
                : null,
          ),
        _ => throw Exception('Unknown node type ${node.runtimeType}'),
      },
    )
    .toList();

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
