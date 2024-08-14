import 'package:jaspr/server.dart';
import 'package:jaspr_markdown_example/app.dart';
import 'package:jaspr_markdown_example/jaspr_options.dart';

void main() {
  Jaspr.initializeApp(options: defaultJasprOptions);

  runApp(Document(
    title: 'jaspr_markdown_example',
    body: App(),
  ));
}
