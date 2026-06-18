import 'package:canya_mobile/common/data/relationship_group.dart';
import 'package:canya_mobile/features/user/application/user_service.dart';
import 'package:canya_mobile/features/user/data/user.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_detail_screen_controller.g.dart';

@riverpod
class UserDetailScreenController
    extends _$UserDetailScreenController
    with UiLoggy {
  @override
  FutureOr<User?> build(
    String userId, {
    List<RelationshipType> relations = const [],
  }) async {
    loggy.debug(
      'initialising controller for $userId and '
      '$relations',
    );

    final service = ref.watch(userServiceProvider);

    final user = service.getUserDetails(
      userId,
      relationships: relations,
    );

    loggy.debug('found user: $user');

    return user;
  }
}
