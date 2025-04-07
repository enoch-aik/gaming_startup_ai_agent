// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:gaming_startup_ai_agent/features/auth/presentation/ui/screens/login.dart'
    as _i2;
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/screens/chat.dart'
    as _i1;
import 'package:gaming_startup_ai_agent/features/onboarding/presentation/screen/onboarding.dart'
    as _i3;

/// generated route for
/// [_i1.ChatScreen]
class ChatRoute extends _i4.PageRouteInfo<void> {
  const ChatRoute({List<_i4.PageRouteInfo>? children})
    : super(ChatRoute.name, initialChildren: children);

  static const String name = 'ChatRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.ChatScreen();
    },
  );
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i4.PageRouteInfo<void> {
  const LoginRoute({List<_i4.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginScreen();
    },
  );
}

/// generated route for
/// [_i3.OnboardingScreen]
class OnboardingRoute extends _i4.PageRouteInfo<void> {
  const OnboardingRoute({List<_i4.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.OnboardingScreen();
    },
  );
}
