import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class UserList extends HookConsumerWidget with UiLoggy {
  const UserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text(
        'Under Construction '
        'for Users',
      ),
    );
  }
}

class UserTile extends HookConsumerWidget with UiLoggy {
  const UserTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text('Under Construction'));
  }
}
