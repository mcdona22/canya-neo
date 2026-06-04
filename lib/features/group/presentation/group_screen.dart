import 'package:canya_mobile/common/routing/util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class GroupScreen extends HookConsumerWidget with UiLoggy {
  final String groupId;

  const GroupScreen({required this.groupId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: createAppBar(context, 'Group Details'),
      body: Center(child: Text('Under Construction '
          'for $groupId')),
    );
  }
}
