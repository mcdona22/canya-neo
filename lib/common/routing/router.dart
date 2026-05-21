import 'package:canya_mobile/features/landing/landing_screen.dart';
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




