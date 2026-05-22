import 'package:canya_mobile/common/async_value_widget.dart';
import 'package:canya_mobile/features/user/data/user.dart';
import 'package:canya_mobile/features/user/data/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class UserList extends HookConsumerWidget with UiLoggy {
  const UserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRepo = ref.watch(userRepositoryProvider);

    final AsyncValue<List<User>> allUsers = ref.watch(
      allUsersProvider,
    );

    //
    // List<User> users = [
    //   User(name: 'John Mac', id: 'dfer34fsdfe34f4f34r4f'),
    //   User(name: 'Shana Boo', id: 'kksooe4ndnodos9002vrr'),
    // ];

    return AsyncValueWidget<List<User>>(
      value: allUsers,
      data: (List<User> users) {
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
          itemBuilder: (_, i) => UserTile(user: users[i]),
        );
      },
    );
  }

  // return ListView.builder(
  //   padding: EdgeInsets.all(8.0),
  //   itemBuilder: (_, i) => UserTile(user: users[i]),
  //   itemCount: users.length,
  // );
}

class UserTile extends HookConsumerWidget with UiLoggy {
  final User user;

  const UserTile({required this.user, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      // Soft ambient shadow depth
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 6.0,
      ),
      // Clip behavior ensures the background color doesn't bleed past rounded borders
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).primaryColor.withOpacity(
            0.3,
          ), // Subdued brand color
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(
          12.0,
        ), // Moderately rounded modern corners
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        leading: CircleAvatar(
          backgroundColor: Theme.of(
            context,
          ).primaryColor.withOpacity(0.1),
          child: Icon(
            Icons.person,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          user.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(user.id ?? '--'),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14.0,
          color: Colors.grey,
        ),
      ),
    );
  }
}
