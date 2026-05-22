import 'package:canya_mobile/features/user/data/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

import '../data/user_summary.dart';

class UserService with UiLoggy {
  final UserRepository _userRepository;

  UserService({required UserRepository userRepository})
    : _userRepository = userRepository;

  Future<List<UserSummary>> getAllUserSummaries() async {
    loggy.debug(
      'UserService: Intercepting data tier payload request.',
    );
    return await _userRepository.findAllUsers();
  }
}

/// Provides the singleton instance of your domain application service
final userServiceProvider = Provider<UserService>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserService(userRepository: userRepository);
});

final allUsersProvider = FutureProvider<List<UserSummary>>((
  ref,
) async {
  final userService = ref.watch(userServiceProvider);
  return await userService.getAllUserSummaries();
});
