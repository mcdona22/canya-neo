import 'package:canya_mobile/common/routing/util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class UserDetailScreen extends HookConsumerWidget
    with UiLoggy {
  final String id;

  const UserDetailScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: createAppBar(context, 'User Detail'),
      body: Center(child: Text(id)),
    );
  }
}
