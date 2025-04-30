import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/core/observers/navigation.dart';
import 'package:gaming_startup_ai_agent/core/services/storage/store.dart';
import 'package:gaming_startup_ai_agent/firebase_options.dart';
import 'package:gaming_startup_ai_agent/src/res/theme/theme.dart';
import 'package:gaming_startup_ai_agent/src/router/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Store.init();

  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instanceFor(app: app);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouter);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp.router(
        title: 'AI Agent',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.light,
        routeInformationParser: router.defaultRouteParser(),
        routeInformationProvider: router.routeInfoProvider(),
        debugShowCheckedModeBanner: false,
        routerDelegate: AutoRouterDelegate(
          router,
          navigatorObservers: () => [AppRouteObservers()],
        ),
        backButtonDispatcher: RootBackButtonDispatcher(),

        // home: const ChatScreen(),
      ),
    );
  }
}
