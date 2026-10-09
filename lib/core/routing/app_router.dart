import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/view/onboarding_screen.dart';
import '../cubits/app_flow_cubit.dart';
import '../cubits/app_flow_state.dart';
import '../di/di.dart';
import 'app_routes.dart';
import 'go_router_listenable_builder.dart';
import 'page_transition_builder.dart';

class AppRouter {
  /// Single GoRouter instance, created once after [getIt.allReady()].
  static final GoRouter router = _createRouter();

  static GoRouter _createRouter() {
    final appFlowCubit = getIt<AppFlowCubit>();

    return GoRouter(
      // Re-evaluates redirect every time AppFlowCubit emits a new state.
      refreshListenable: GoRouterListenableBuilder(appFlowCubit.stream),
      redirect: (context, state) {
        final flowState = appFlowCubit.state;
        final currentPath = state.matchedLocation;

        // Guard: onboarding not done → always land on onboarding.
        if (flowState == AppFlowState.onboarding &&
            currentPath != AppRoutes.onboarding) {
          return AppRoutes.onboarding;
        }

        // Guard: onboarding done → never show onboarding again.
        if (flowState == AppFlowState.home &&
            currentPath == AppRoutes.onboarding) {
          return AppRoutes.home;
        }

        return null; // no redirect needed
      },
      routes: [
        _route(
          AppRoutes.onboarding,
          builder: (context, state) => const OnboardingScreen(),
        ),
        _route(
          AppRoutes.home,
          builder: (context, state) => const Placeholder(),
        ),
      ],
    );
  }

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
