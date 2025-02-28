import 'package:jaspr/jaspr.dart';
import 'package:jaspr_markdown/src/syntax.dart';
import 'package:test/test.dart';

void main() {
  test('ComponentBlockSyntax constructor', () {
    final syntax = ComponentBlockSyntax(importComponents: []);
    expect(syntax.importComponents, isEmpty);
  });

  test('ComponentBlockSyntax importComponents', () {
    final syntax = ComponentBlockSyntax(importComponents: [DomComponent]);
    expect(syntax.importComponents, isNotEmpty);
    expect(syntax.importComponents.first, DomComponent);
  });
}
