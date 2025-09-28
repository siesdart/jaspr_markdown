[![Build](https://img.shields.io/github/actions/workflow/status/siesdart/jaspr_markdown/build.yml)](https://github.com/siesdart/jaspr_markdown/actions/workflows/build.yml)
[![Pub](https://img.shields.io/pub/v/jaspr_markdown)](https://pub.dev/packages/jaspr_markdown)
[![License](https://img.shields.io/github/license/siesdart/jaspr_markdown?color=blue)](https://github.com/siesdart/jaspr_markdown/blob/main/LICENSE)
![GitHub stars](https://img.shields.io/github/stars/siesdart/jaspr_markdown?style=flat&label=stars&labelColor=333940&color=8957e5&logo=github)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

A Markdown renderer for Jaspr. It lets you use Jaspr components in Markdown. You can import components like [MDX](https://mdxjs.com/).

### Usage

You can add Jaspr components to Markdown by just writing HTML tags with the constructor name as the tag name and the constructor arguments as the attributes. Named constructors are indicated using `-` instead of `.`. The types of components to be used in Markdown must be included in the `importComponents` list of `ComponentBlockSyntax`. `jaspr_markdown` is built on top of [markdown](https://pub.dev/packages/markdown) package, so you can use syntaxes provided by it too.

```dart
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_markdown/jaspr_markdown.dart';

class CustomCard extends StatelessComponent {
  const CustomCard({
    required this.foo,
    required this.bar,
    required this.baz,
    this.children,
  }) : _dotted = false;

  const CustomCard.dotted({
    required this.foo,
    required this.bar,
    required this.baz,
    this.children,
  }) : _dotted = true;

  (...)
}

class App extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return Markdown(
      markdown: markdown,
      blockSyntaxes: [
        ComponentBlockSyntax(importComponents: const [CustomCard])
      ],
    );
  }
}

const markdown = '''
# Markdown

## First

<CustomCard foo="foo" bar="1" baz="bool">
  <span>baz</span>
</CustomCard>

## Second

<CustomCard foo="bar" bar="100" baz/>

## Third

<CustomCard-dotted foo="baz" bar="2">
  <p>qux<span>quux</span></p><small>200</small>
</CustomCard-dotted>
''';
```

See all examples code [here](example).

### Notice

`jaspr_markdown` uses `dart:mirrors`, so AOT compilation is not supported. Therefore, you need to use JIT compilation when building Jaspr as server mode:

```bash
jaspr build -t jit-snapshot
```
