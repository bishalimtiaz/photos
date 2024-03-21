import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photos/app/dependency_provider/dependency_provider.dart';
import 'package:photos/app/routes/app_router.dart';

class AppService {
  AppService._internal();

  static final AppService _instance = AppService._internal();

  factory AppService() => _instance;

  BuildContext get context =>
      appRouter.routerDelegate.navigatorKey.currentContext!;

  RouteMatchList get _matchList {
    final RouteMatch lastMatch =
        appRouter.routerDelegate.currentConfiguration.last;
    return lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : appRouter.routerDelegate.currentConfiguration;
  }

  static String? get currentRouteName =>
      appRouter.routerDelegate.currentConfiguration.last.route.name;

  Object? get argument => _matchList.extra;

  Map<String, String> get queryParams => _matchList.uri.queryParameters;

  Map<String, String> get pathParams => _matchList.pathParameters;

  bool get hasQuery => _matchList.uri.hasQuery;

  static String get path =>
      appRouter.routerDelegate.currentConfiguration.last.matchedLocation;

  Future<void> start() async {
    DependencyProvider().provideDI();
  }
}
