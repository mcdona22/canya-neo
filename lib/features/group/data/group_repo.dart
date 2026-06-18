import 'package:canya_mobile/common/data/relationship_group.dart';
import 'package:canya_mobile/common/db/base_graph_repository.dart';
import 'package:canya_mobile/common/db/graph_gateway.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

import 'group.dart';

class GroupRepo extends BaseGraphRepository<Group>
    with UiLoggy {
  GroupRepo({required super.gateway})
    : super(apiKeyRoot: 'group');

  @override
  Group entityFromJson(Map<String, dynamic> json) =>
      Group.fromJson(json);

  @override
  String buildFindAllQuery() {
    return r'''
        query GetAllGroups {
          groups(options: { sort: [{ title: ASC }] }) {
            id
            title
            subtitle
        } 
      }
    ''';
  }

  @override
  String buildFindByIdQuery(
    List<RelationshipType> relations,
  ) {
    // TODO: implement buildFindByIdQuery
    throw UnimplementedError();
  }

  @override
  // TODO: implement entityTypeName
  String get entityTypeName => 'Group';

  @override
  Group copyWithNodes(
    Group entity,
    List<RelationshipGroup> nodes,
  ) {
    // TODO: implement copyWithNodes
    throw UnimplementedError();
  }
}

final groupRepoProvider = Provider<GroupRepo>((ref) {
  final gateway = ref.watch(graphGatewayProvider);
  return GroupRepo(gateway: gateway);
});

final allGroupsProvider = FutureProvider<List<Group>>((
  ref,
) async {
  final groupRepository = ref.watch(groupRepoProvider);
  return groupRepository
      .findAllEntities(); // Swapped to the base class method
});
