import 'package:canya_mobile/common/data/relationship_group.dart';
import 'package:canya_mobile/features/group/data/group.dart';
import 'package:canya_mobile/features/group/data/group_repository.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_service.g.dart';

class GroupService with UiLoggy {
  final GroupRepository _groupRepository;

  GroupService({required this._groupRepository});

  // : _groupRepository = groupRepository;

  Future<Group?> getGroupDetails(
    String groupId, {
    List<RelationshipType> relationships = const [],
  }) async {
    loggy.debug(
      'searching for group with an id of "$groupId"  and params $relationships',
    );

    final foundGroup = await _groupRepository.findGroupById(
      groupId,
      fetchRelations: relationships,
    );
    loggy.debug('found group', foundGroup);
    return foundGroup;
  }
}

@riverpod
GroupService groupService(Ref ref) {
  final groupRepository = ref.watch(
    groupRepositoryProvider,
  );
  return GroupService(groupRepository: groupRepository);
}
