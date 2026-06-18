import 'package:canya_mobile/common/data/relationship_group.dart';
import 'package:canya_mobile/features/user/data/user.dart';
import 'package:canya_mobile/features/user/data/user_repository.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_service.g.dart';

class UserService with UiLoggy {
  final UserRepository _userRepository;

  UserService({required this._userRepository});

  Future<User?> getUserDetails(
    String userId, {
    List<RelationshipType> relationships = const [],
  }) async {
    loggy.debug('searching for users - id $relationships');

    final foundUser = await _userRepository.findEntityById(
      userId,
      fetchRelations: relationships,
    );
    loggy.debug('Found $foundUser');

    return foundUser;
  }
}

@riverpod
UserService userService(Ref ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserService(userRepository: userRepository);
}
