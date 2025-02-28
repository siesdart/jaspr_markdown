import 'package:jaspr_markdown/src/ast.dart';
import 'package:test/test.dart';

void main() {
  test('Component constructor', () {
    final component = Component(
      String,
      'constructorName',
      {'attribute1': 'value1', 'attribute2': 'value2'},
      [],
    );

    expect(component.type, String);
    expect(component.constructorName, const Symbol('constructorName'));
    expect(component.attributes['attribute1'], 'value1');
    expect(component.attributes['attribute2'], 'value2');
    expect(component.children, isEmpty);
    expect(component.namedArguments, {
      const Symbol('attribute1'): 'value1',
      const Symbol('attribute2'): 'value2',
    });
  });

  test('namedArguments getter', () {
    final component = Component(
      String,
      'constructorName',
      {'attr1': 'val1', 'attr2': 'val2'},
      [],
    );
    expect(component.namedArguments, {
      const Symbol('attr1'): 'val1',
      const Symbol('attr2'): 'val2',
    });
  });
}
