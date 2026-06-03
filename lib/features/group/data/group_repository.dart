import 'package:canya_mobile/common/data/relationship_ref.dart';
import 'package:canya_mobile/common/db/graph_gateway.dart';
import 'package:canya_mobile/features/group/data/group.dart';
import 'package:canya_mobile/features/group/data/group_summary.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class GroupRepository with UiLoggy {
  final GraphGateway _gateway;

  GroupRepository({required GraphGateway gateway})
      : _gateway = gateway;

  Future<List<GroupSummary>> findAllGroups() async {
    loggy.debug('Finding all users...');
    const query = r'''
        query GetAllGroupSummary {
          groups(options: { sort: [{ name: ASC }] }) {
            id
            name
            members {
              id
              label:name
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
    final List<dynamic> userJson = data['groups'] ?? [];
    loggy.debug('Data found', data['groups']);

    return userJson.map((json) {
      final map = json as Map<String, Object?>;

      final List<dynamic> groupsJson =
      map['members'] as List<dynamic>;
      final groupRefs = groupsJson
          .map((g) => RelationshipRef.fromJson(g))
          .toList();

      final group = Group.fromJson(map);
      return GroupSummary(
        group: group,
        groupUsers: groupRefs,
      );
    }).toList();
  }
}

final groupRepositoryProvider = Provider<GroupRepository>((
    ref,) {
  final gateway = ref.watch(graphGatewayProvider);
  return GroupRepository(gateway: gateway);
});

final allGroupsProvider =
FutureProvider<List<GroupSummary>>((ref) async {
  final groupRepository = ref.watch(
    groupRepositoryProvider,
  );
  return groupRepository.findAllGroups();
});
