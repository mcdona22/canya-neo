import 'Navigable.dart';

enum RelationshipType {
  members('members'),
  invitedTo('invitedTo'),
  memberOf('memberOf');

  final String graphQlField;

  const RelationshipType(this.graphQlField);
}

class RelationshipGroup {
  final RelationshipType type; // Your typed routing enum
  final List<Navigable> nodes; // The connected
  // child nodes

  const RelationshipGroup({
    required this.type,
    this.nodes = const [],
  });

  @override
  String toString() {
    return 'RelationshipGroup{type: $type, nodes: $nodes}';
  }
}
