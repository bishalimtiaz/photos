import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photos/app/core/base/screen_builder.dart';
import 'package:photos/app/presentation/modules/album/album_screen.dart';
import 'package:photos/app/presentation/modules/gallery/gallery_screen.dart';
import 'package:photos/app/presentation/modules/photo/photo_screen.dart';
import 'package:photos/app/presentation/modules/photo_access/photo_access_screen.dart';
import 'package:photos/app/presentation/modules/splash/splash_screen.dart';
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
    ScreenBuilder<PhotoAccessScreen>(
      path: _Path.photoAccess,
      name: AppRoutes.photoAccess,
      screenBuilder: (BuildContext context, GoRouterState state) {
        return const PhotoAccessScreen();
      },
    ),
    ScreenBuilder<AlbumScreen>(
      path: _Path.album,
      name: AppRoutes.album,
      screenBuilder: (BuildContext context, GoRouterState state) {
        return const AlbumScreen();
      },
    ),
    ScreenBuilder<GalleryScreen>(
      path: _Path.gallery,
      name: AppRoutes.gallery,
      screenBuilder: (BuildContext context, GoRouterState state) {
        return const GalleryScreen();
      },
    ),
    ScreenBuilder<PhotoScreen>(
      path: _Path.photo,
      name: AppRoutes.photo,
      screenBuilder: (BuildContext context, GoRouterState state) {
        return const PhotoScreen();
      },
    ),
  ],
);
