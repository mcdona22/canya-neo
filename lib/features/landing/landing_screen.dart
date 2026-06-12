import 'package:canya_mobile/common/presentation/centred_constrained_widget.dart';
import 'package:canya_mobile/common/routing/util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class LandingScreen extends HookConsumerWidget
    with UiLoggy {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: createAppBar(context, 'Welcome to CanYa '),
      body: CentredConstrainedWidget(
        child: const Text(
          'Refactoring - dont need this '
              'from PoC',
        ),
      ),
    );
  }
}
