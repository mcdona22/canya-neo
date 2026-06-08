abstract class Navigable {
  String? get id;

  String get title;

  String? get subtitle;

  /// Self-referential list allowing recursive nesting
  List<Navigable> get connectedNodes;
}
