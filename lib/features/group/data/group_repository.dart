import 'package:canya_mobile/common/db/graph_gateway.dart';
import 'package:canya_mobile/features/group/data/group.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class GroupRepository with UiLoggy {
  final GraphGateway _gateway;

  GroupRepository({required GraphGateway gateway})
      : _gateway = gateway;

  Future<Group?> findGroupById(String groupId) async {
    loggy.debug('fetching group "$groupId"');
    const query = r'''
      query GetGroupById($id:ID!){
        groups(where: {id: $id}){
          id
          title
          subtitle
         }
        }
    ''';

    final Map<String, dynamic>? data = await _gateway
        .execute(query: query, vars: {'id': groupId});

    if (data == null) {
      loggy.warning(
        'Query for $groupId failed to return data',
      );
      return null;
    }

    final List<dynamic> json = data['groups'];

    return json.isEmpty ? null : Group.fromJson(json.first);
  }

  Future<List<Group>> findAllGroups() async {
    loggy.debug('Finding all users...');
    const query = r'''
        query GetAllGroupSummary {
          groups(options: { sort: [{ title: ASC }] }) {
            id
            title
            subtitle
            members {
              id
              name
            }
           } 
        }

      ''';

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

    // return userJson.map((json) {
    //   final map = json as Map<String, Object?>;
    //
    //   final List<dynamic> groupsJson =
    //   map['members'] as List<dynamic>;
    //   final groupRefs = groupsJson
    //       .map((g) => RelationshipRef.fromJson(g))
    //       .toList();
    //
    //   final group = Group.fromJson(map);
    //   return GroupSummary(
    //     group: group,
    //     groupUsers: groupRefs,
    //   );
    // }).toList();
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
