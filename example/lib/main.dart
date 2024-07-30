import 'package:jaspr/server.dart';
import 'package:jaspr_markdown_example/app.dart';

void main() {
  Jaspr.initializeApp();

  runApp(Document(
    title: 'jaspr_markdown_example',
    body: App(),
  ));
}
