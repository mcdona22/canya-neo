import 'package:canya_mobile/common/data/navigable_summary.dart';
import 'package:canya_mobile/common/data/relationship_group.dart';
import 'package:canya_mobile/common/db/graph_gateway.dart';
import 'package:canya_mobile/features/group/data/group.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class GroupRepository with UiLoggy {
  final GraphGateway _gateway;

  GroupRepository({required GraphGateway gateway})
      : _gateway = gateway;

  Future<Group?> findGroupById(String groupId, {
    List<RelationshipType> fetchRelations = const [],
  }) async {
    loggy.debug(
      'fetching group "$groupId" and $fetchRelations',
    );
    final query = _GroupQueries.findGroupById(
      relations: fetchRelations,
    );

    // loggy.debug('query is: $query');

    final Map<String, dynamic>? data = await _gateway
        .execute(query: query, vars: {'id': groupId});

    if (data == null) {
      loggy.warning(
        'Query for $groupId failed to return data',
      );
      return null;
    }

    final List<dynamic> json = data['groups'];
    if (json.isEmpty) return null;
    final List<dynamic> members = json.first['members'];
    // loggy.debug('Members: $members');
    final first = json.first;

    Group foundEntity = Group.fromJson(json.first);

    // for (final r in fetchRelations) {
    //   loggy.debug('Iterating:  the nodes for ${r.name}');
    //   final List<dynamic> currentNodes = json.first[r.name];
    //   loggy.debug('Current nodes for $r is $currentNodes');
    // }

    // final memberNodes =
    //     members.map((json) => User.fromJson(json)).toList()
    //         as List<Navigable>;
    //
    // loggy.debug('users : $memberNodes');
    //
    // final membersGroup = RelationshipGroup(
    //   type: RelationshipType.members,
    //   nodes: memberNodes,
    // );

    final List<RelationshipGroup> relationships = [];
    for (final r in fetchRelations) {
      loggy.debug('Find relationships for $r');
      final List<dynamic> foundRelations = json.first[r
          .graphQlField];
      loggy.debug('found links', foundRelations);
      final nodes = foundRelations.map((r) =>
          NavigableSummary.fromJson
            (r)).toList();
      loggy.debug('found navigables: $foundRelations');
      relationships.add(RelationshipGroup(type: r,
          nodes: nodes));
    }

    // process the payload and grab the relevant
    // navigable links as reuired by the provided paran
    loggy.debug('navs: $relationships');
    foundEntity = foundEntity.copyWith(
      nodes: relationships,
    );

    return foundEntity;
  }

  /**
   * Finds all the group nodes using the query defined below
   */
  Future<List<Group>> findAllGroups() async {
    loggy.debug('Finding all groups...');

    final query = _GroupQueries.allGroupSummary;
    loggy.debug('query', query);

    final Map<String, dynamic>? data = await _gateway
        .execute(query: query);

    if (data == null) {
      loggy.warning('Query returned a null payload');
      return [];
    }
    final List<dynamic> groupJson = data['groups'] ?? [];
    loggy.debug('Data found', groupJson);

    return groupJson.map((json) {
      final map = json as Map<String, dynamic>;
      return Group.fromJson(map);
    }).toList();
  }
}

final groupRepositoryProvider = Provider<GroupRepository>((
    ref,) {
  final gateway = ref.watch(graphGatewayProvider);
  return GroupRepository(gateway: gateway);
});

final allGroupsProvider = FutureProvider<List<Group>>((
    ref,) async {
  final groupRepository = ref.watch(
    groupRepositoryProvider,
  );
  return groupRepository.findAllGroups();
});

mixin _GroupQueries {
  static const String allGroupSummary = r'''
    query GetAllGroupSummary {
      groups(options: { sort: [{ title: ASC }] }) {
        id
        title
        subtitle
      } 
    }
  ''';

  static String findGroupById({
    List<RelationshipType> relations = const [],
  }) {
    final String relationSection = relations
        .map((relation) {
      return '''
          ${relation.graphQlField} {
          id
          title
          subtitle
        }''';
    })
        .join('\n');

    return '''
      query GetGroupById(\$id: ID!) {
        groups(where: { id: \$id }) {
          id
          title
          subtitle
          $relationSection
        }
       }
      
    ''';
  }
}
