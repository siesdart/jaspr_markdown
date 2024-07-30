import 'package:markdown/markdown.dart';

/// A Jaspr component.
class Component extends Element {
  /// Instantiates a Jaspr [type].[constructorName] component with constructor
  /// [attributes] and [children].
  Component(
    this.type,
    String? constructorName,
    Map<String, String> attributes,
    List<Node>? children,
  )   : constructorName = Symbol(constructorName ?? ''),
        super(type.toString(), children) {
    super.attributes.addAll(attributes);
  }

  /// Type of the component.
  final Type type;

  /// Name of the constructor to instantiate.
  final Symbol constructorName;

  /// Get named arguments of the constructor for instantiation.
  Map<Symbol, dynamic> get namedArguments =>
      attributes.map((key, value) => MapEntry(Symbol(key), value));
}
