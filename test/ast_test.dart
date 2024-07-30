import 'package:jaspr/jaspr.dart' as jaspr;
import 'package:jaspr_markdown/src/ast.dart';
import 'package:markdown/markdown.dart';
import 'package:test/test.dart';

void main() {
  group('Component', () {
    test('Basic initialization', () {
      final component = Component(jaspr.StatelessComponent, null, {}, null);
      expect(component.type, equals(jaspr.StatelessComponent));
      expect(component.constructorName, equals(Symbol.empty));
      expect(component.attributes, isEmpty);
      expect(component.children, isNull);
    });
    test('.constructorName is the symbol of the constructorName argument', () {
      final component = Component(jaspr.StatelessComponent, 'from', {}, null);
      expect(component.constructorName, equals(#from));
    });
    test('.attributes has the same attributes to the attributes argument', () {
      final component = Component(
        jaspr.StatelessComponent,
        null,
        {'foo': 'foo', 'bar': '1', 'baz': 'bool'},
        null,
      );

      expect(component.attributes, hasLength(3));
      expect(component.attributes, containsPair('foo', 'foo'));
      expect(component.attributes, containsPair('bar', '1'));
      expect(component.attributes, containsPair('baz', 'bool'));
    });
    test('.children has the same nodes to the attributes children', () {
      final component = Component(
        jaspr.StatelessComponent,
        null,
        {},
        [Text('foo'), Element('div', null), Text('bar')],
      );

      expect(component.children, hasLength(3));
      expect(component.children![0], isA<Text>());
      expect((component.children![0] as Text).text, equals('foo'));
      expect(component.children![1], isA<Element>());
      expect((component.children![1] as Element).tag, equals('div'));
      expect(component.children![2], isA<Text>());
      expect((component.children![2] as Text).text, equals('bar'));
    });
    test('.namedArguments is a conversion of .attributes into Symbol form', () {
      final component = Component(
        jaspr.StatelessComponent,
        null,
        {'foo': 'foo', 'bar': '1', 'baz': 'bool'},
        null,
      );

      expect(component.namedArguments, hasLength(3));
      expect(component.namedArguments, containsPair(#foo, 'foo'));
      expect(component.namedArguments, containsPair(#bar, '1'));
      expect(component.namedArguments, containsPair(#baz, 'bool'));
    });
  });
}
