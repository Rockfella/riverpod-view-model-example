import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_view_model_example/modules/counter/counter_screen.dart';
import 'package:riverpod_view_model_example/modules/preferences/preferences_screen.dart';

class AppRouter {
  void go(String route) {
    goRouter.go(route);
  }
String getCurrentLocation() {
    final RouteMatch lastMatch =
        goRouter.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : goRouter.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
  GoRouter goRouter = GoRouter(
    initialLocation: "/counter",
    routes: [
      GoRoute(
        path: "/counter",
        pageBuilder: _counter,
      ),
      GoRoute(
        path: "/preferences",
        pageBuilder: _preferences,
      ),
    ],
  );

  
  static Page<void> _counter(context, GoRouterState state) {
    return NoTransitionPage<void>(
      key: state.pageKey,
      child: CounterScreen(),
    );
  }

  static Page<void> _preferences(context, GoRouterState state) {
    return NoTransitionPage<void>(
      key: state.pageKey,
      child: PreferencesScreen(),
    );
  }
}
