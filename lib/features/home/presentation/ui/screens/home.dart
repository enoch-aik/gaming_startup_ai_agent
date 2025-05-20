import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/features/auth/presentation/ui/screens/login.dart';
import 'package:gaming_startup_ai_agent/features/auth/providers.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/screens/chat.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage(name: 'home')
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (data) {
        return data != null ? ChatScreen() : LoginScreen();
      },
      error: (e, _) {
        return Center(child: Text(e.toString()));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
