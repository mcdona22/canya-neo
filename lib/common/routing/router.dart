import 'package:canya_mobile/features/group/presentation/group_screen.dart';
import 'package:canya_mobile/features/landing/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoute { home, group }

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      pageBuilder: (_, state) => MaterialPage(
        child: LandingScreen(),
        key: state.pageKey,
      ),
    ),

    GoRoute(
      path: '/group',
      name: AppRoute.group.name,
      pageBuilder: (_, state) => MaterialPage(
        child: GroupScreen(),
        key: state.pageKey,
      ),
    ),
  ],
);
