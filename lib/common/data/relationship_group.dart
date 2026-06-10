import 'Navigable.dart';

enum RelationshipType {
  members('members'),
  invitedTo('invitedTo');

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
}
