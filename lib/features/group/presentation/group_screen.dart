import 'package:canya_mobile/common/routing/util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class GroupScreen extends HookConsumerWidget with UiLoggy {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: createAppBar(
          context,
          'Group Details',
        ),
        body: const Center(

            child: Text('Under Construction')));
  }
}
