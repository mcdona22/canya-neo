import 'package:canya_mobile/features/group/data/group.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../application/group_service.dart';

part 'group_screen_controller.g.dart';

@riverpod
class GroupScreenController extends _$GroupScreenController
    with UiLoggy {
  @override
  FutureOr<Group?> build(String groupId) async {
    logDebug(
      'Initializing GroupScreenController for group: $groupId',
    );

    // Read the service layer directly using the generic Ref
    final groupService = ref.watch(groupServiceProvider);

    // Fetch the initial data. Returning this automatically wraps the
    // provider's state in an AsyncValue (AsyncLoading -> AsyncData/AsyncError).
    return groupService.getGroupDetails(groupId);
  }
}
