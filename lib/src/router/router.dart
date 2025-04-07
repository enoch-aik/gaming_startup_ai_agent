import 'package:auto_route/auto_route.dart';
import 'package:gaming_startup_ai_agent/src/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {

  @override
  RouteType get defaultRouteType => RouteType.adaptive();
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page,initial: true),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: ChatRoute.page),
  ];
}