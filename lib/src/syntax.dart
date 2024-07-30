import 'dart:mirrors';

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html;
import 'package:jaspr/jaspr.dart' as jaspr;
import 'package:jaspr_markdown/src/ast.dart';
import 'package:markdown/markdown.dart';

/// Parses Jaspr components.
class ComponentBlockSyntax extends HtmlBlockSyntax {
  /// Instantiates a Jaspr component syntax with [importComponents].
  ComponentBlockSyntax({required this.importComponents})
      : assert(
          importComponents.every(
            (e) => reflectClass(e).isSubtypeOf(reflectType(jaspr.Component)),
          ),
          'The importComponents must only contain Jaspr Component types.',
        );

  /// List of component types to be used in Markdown.
  final List<Type> importComponents;

  @override
  Node parse(BlockParser parser) {
    final text = super.parse(parser) as Text;
    final fragment = html.HtmlParser(
      text.text,
      lowercaseAttrName: false,
      lowercaseElementName: false,
    ).parseFragment();
    final nodes = _buildElements(fragment.nodes).toList();
    return nodes.length > 1
        ? Element('_', nodes)
        : nodes.firstOrNull ?? Text('');
  }

  Iterable<Node> _buildElements(dom.NodeList nodeList) sync* {
    for (final node in nodeList) {
      if (node is dom.Text) {
        yield Text(node.text);
      } else if (node is dom.Element) {
        if (node.localName!.startsWith(RegExp('[A-Z]'))) {
          final splittedName = node.localName!.split('-');
          final componentType = importComponents
              .where((type) => splittedName[0] == type.toString())
              .firstOrNull;
          if (componentType != null) {
            yield Component(
              componentType,
              splittedName.elementAtOrNull(1),
              node.attributes.cast(),
              _buildElements(node.nodes).toList(),
            );
            continue;
          }
        }

        yield Element(
          node.localName!,
          _buildElements(node.nodes).toList(),
        )..attributes.addAll(node.attributes.cast());
      }
    }
  }
}
