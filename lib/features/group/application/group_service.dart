import 'package:canya_mobile/common/data/relationship_group.dart';
import 'package:canya_mobile/features/group/data/group.dart';
import 'package:canya_mobile/features/group/data/group_repository.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_service.g.dart';

class GroupService with UiLoggy {
  final GroupRepository _groupRepository;

  GroupService({required GroupRepository groupRepository})
      : _groupRepository = groupRepository;

  Future<Group?> getGroupDetails(String groupId, {
    List<RelationshipType> relationships = const [],
  }) async {
    loggy.debug(
        'searching for group with an id of "$groupId"  and params $relationships');
    return _groupRepository.findGroupById(
      groupId,
      fetchRelations: [
        RelationshipType.members,
        RelationshipType.invitedTo,
      ],
    );
  }
}

@riverpod
GroupService groupService(Ref ref) {
  final groupRepository = ref.watch(
    groupRepositoryProvider,
  );
  return GroupService(groupRepository: groupRepository);
}
