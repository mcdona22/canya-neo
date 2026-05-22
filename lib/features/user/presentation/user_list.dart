import 'package:canya_mobile/common/async_value_widget.dart';
import 'package:canya_mobile/features/user/data/user_repository.dart';
import 'package:canya_mobile/features/user/presentation/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

import '../data/user_summary.dart';

class UserList extends HookConsumerWidget with UiLoggy {
  const UserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRepo = ref.watch(allUsersProvider);

    final AsyncValue<List<UserSummary>> allUsers = ref
        .watch(allUsersProvider);

    return AsyncValueWidget<List<UserSummary>>(
      value: allUsers,
      data: (List<UserSummary> users) {
        loggy.debug(
          'Rendering UserList viewport with ${users.length} retrieved graph nodes.',
        );

        if (users.isEmpty) {
          return const Center(
            child: Text(
              'No users discovered in the graph engine yet.',
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: users.length,
          itemBuilder: (_, i) =>
              UserTile(userSummary: users[i]),
        );
      },
    );
  }
}
