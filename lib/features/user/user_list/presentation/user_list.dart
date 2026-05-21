import 'package:canya_mobile/features/user/data/user.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class UserList extends HookConsumerWidget with UiLoggy {
  const UserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<User> users = [
      User(name: 'John'),
      User(name: 'Boo'),
    ];

    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemBuilder: (_, i) => UserTile(user: users[i]),
      itemCount: users.length,
    );
  }
}

class UserTile extends HookConsumerWidget with UiLoggy {
  final User user;

  const UserTile({required this.user, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(title: Text(user.name));
  }
}
