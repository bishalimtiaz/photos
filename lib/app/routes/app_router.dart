import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photos/app/core/base/screen_builder.dart';
import 'package:photos/app/presentaton/modules/splash/splash_screen.dart';
import 'package:photos/app/routes/app_routes.dart';
import 'package:photos/app/routes/go_router_observer.dart';
import 'package:photos/app/routes/navigation_helper.dart';

abstract class _Path {
  static const String splash = '/splash';
  static const String album = '/album';
  static const String gallery = '/gallery';
  static const String photo = '/photo';
  static const String photoAccess = '/photo-access';
}

final GoRouter appRouter = GoRouter(
  initialLocation: _Path.splash,
  navigatorKey: NavigationHelper().parentNavigatorKey,
  observers: <NavigatorObserver>[GoRouterObserver()],
  routes: <RouteBase>[
    ScreenBuilder<SplashScreen>(
      path: _Path.splash,
      name: AppRoutes.splash,
      screenBuilder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
  ],
);
