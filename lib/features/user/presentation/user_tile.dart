import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

import '../data/user.dart';

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
