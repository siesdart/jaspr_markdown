import 'package:jaspr_markdown/src/component.dart';
import 'package:test/test.dart';

void main() {
  test('Markdown component', () {
    const markdown = Markdown(markdown: '# Hello World');
    expect(markdown.markdown, '# Hello World');
  });
}
