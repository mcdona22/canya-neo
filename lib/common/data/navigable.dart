import 'relationship_group.dart';

abstract class Navigable {
  String? get id;

  String get title;

  String? get subtitle;

  /// Self-referential list allowing recursive nesting
  List<RelationshipGroup> get connectedNodes;
}
