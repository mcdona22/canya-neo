import 'package:canya_mobile/common/db/graph_gateway.dart';
import 'package:canya_mobile/features/user/data/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class UserRepository with UiLoggy {
  final GraphGateway _gateway;

  UserRepository({required GraphGateway gateway})
    : _gateway = gateway;

  Future<List<User>> findAllUsers() async {
    loggy.debug('Finding all users...');
    const query = r'''
    query GetAllUsers {
      users(options: { sort: [{ name: ASC }] }) {
        id
        name
      }
    }
  ''';

    final Map<String, dynamic>? data = await _gateway
        .execute(query: query);

    if (data == null) {
      loggy.warning('Query returned a null payload');
      return [];
    }
    final List<dynamic> userJson = data['users'] ?? [];
    loggy.debug('Data found', data['users']);

    return userJson
        .map(
          (json) =>
              User.fromJson(json as Map<String, Object?>),
        )
        .toList();
  }
}

final userRepositoryProvider = Provider<UserRepository>((
  ref,
) {
  final gateway = ref.watch(graphGatewayProvider);
  return UserRepository(gateway: gateway);
});

final allUsersProvider = FutureProvider<List<User>>((
  ref,
) async {
  // Grab your configured repository singleton
  final userRepository = ref.watch(userRepositoryProvider);

  // Execute the network traversal line
  return await userRepository.findAllUsers();
});
