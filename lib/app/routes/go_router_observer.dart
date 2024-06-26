import 'package:flutter/material.dart';

import 'package:photos/app/core/utils/log.dart';
import 'package:photos/app/routes/navigation_helper.dart';

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    Log.info('Pushing Route: ${route.settings.name}');
    NavigationHelper().handlePush(route.settings.name);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    Log.info('Popping Route: ${route.settings.name}');
    NavigationHelper().handlePop(route.settings.name);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    Log.info('Removing Route: ${route.settings.name}');
    NavigationHelper().handlePop(route.settings.name);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    Log.info('Replaced Route: ${oldRoute?.settings.name} '
        'By Route: ${newRoute?.settings.name}');
  }
}
