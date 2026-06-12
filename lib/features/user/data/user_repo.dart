import 'package:canya_mobile/common/db/base_graph_repository.dart';
import 'package:canya_mobile/common/db/graph_gateway.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

import 'user.dart';

class UserRepo extends BaseGraphRepository<User>
    with UiLoggy {
  UserRepo({required super.gateway})
      : super(apiKeyRoot: 'users');

  @override
  User entityFromJson(Map<String, dynamic> json) =>
      User.fromJson(json);

  @override
  String buildFindAllQuery() {
    return r'''
        query GetAllUserSummary {
          users(options: { sort: [{ title: ASC }] }) {
            id
            title
            subtitle
        } 
      }
    ''';
  }
}

final userRepoProvider = Provider<UserRepo>((ref) {
  final gateway = ref.watch(graphGatewayProvider);
  return UserRepo(gateway: gateway);
});

final allUsersProvider = FutureProvider<List<User>>((
    ref,) async {
  final groupRepository = ref.watch(userRepoProvider);
  return groupRepository
      .findAllEntities(); // Swapped to the base class method
});
