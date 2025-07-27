import 'package:jaspr/jaspr.dart';

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

  final String foo;
  final int bar;
  final bool baz;
  final List<Component>? children;

  final bool _dotted;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      [
        span([text('foo: '), text(foo)]),
        br(),
        span([text('bar*2: '), text((bar * 2).toString())]),
        br(),
        span([text('!baz: '), text((!baz).toString())]),
        if (children != null)
          details([
            summary([text('children')]),
            ...children!,
          ]),
      ],
      styles: Styles(
        border: Border(style: _dotted ? BorderStyle.dotted : BorderStyle.solid),
        padding: Spacing.all(24.px),
        radius: BorderRadius.circular(12.px),
      ),
    );
  }
}
