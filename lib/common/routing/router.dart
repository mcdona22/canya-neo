import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

enum AppRoute {
  home
}

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/',
    name: AppRoute.home.name,
        pageBuilder: (_, state) => MaterialPage(
          child: LandingScreen(),
          key: state.pageKey,
        )),

  ]
);



class LandingScreen extends HookConsumerWidget with UiLoggy {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center( child:
         Text('Under Construction')
      ));
  }
}
