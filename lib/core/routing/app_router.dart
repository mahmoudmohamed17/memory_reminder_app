import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';
import 'page_transition_builder.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      _route(
        AppRoutes.splash,
        builder: (context, state) => const Placeholder(),
      ),
    ],
  );
  
  static GoRoute _route(
    String path, {
    required Widget Function(BuildContext context, GoRouterState state) builder,
    String? Function(BuildContext context, GoRouterState state)? redirect,
    List<RouteBase> routes = const [],
    PageTransitionType transition = PageTransitionType.platformAdaptive,
  }) {
    return GoRoute(
      path: path,
      redirect: redirect,
      routes: routes,
      pageBuilder: (context, state) {
        final child = builder(context, state);
        return PageTransitionBuilder.build(
          child: child,
          key: state.pageKey,
          transition: transition,
        );
      },
    );
  }
}
