import 'package:auto_route/auto_route.dart';
import 'package:gaming_startup_ai_agent/features/auth/providers.dart';
import 'package:gaming_startup_ai_agent/src/router/router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  final Ref _ref;
  AppRouter(this._ref);
  @override
  RouteType get defaultRouteType => RouteType.adaptive();
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: OnboardingRoute.page,initial: true),
    AutoRoute(page: ChatRoute.page,/*guards: [RedirectToLoginGuard(_ref)]*/),
    //AutoRoute(page: Home.page),
  ];
}


class RedirectToLoginGuard extends AutoRouteGuard {
  final Ref _ref;
  RedirectToLoginGuard(this._ref);
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {

    final currentUser = _ref.read(currentUserDetails);

    if(currentUser == null) {
      // If the user is not logged in, redirect to LoginRoute
      router.replaceAll([const LoginRoute()]);
    } else {
      // If the user is logged in, continue to the requested route
      resolver.next();
    }
  }
}