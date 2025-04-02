import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppRouteObservers extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (kDebugMode) {
      debugPrint('New route pushed: ${route.settings.name}');
    }
  }

  // only override to observe tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    if (kDebugMode) {
      debugPrint('Tab route visited: ${route.name}');
    }
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    if (kDebugMode) {
      debugPrint('Tab route re-visited: ${route.name}');
    }
  }
}
