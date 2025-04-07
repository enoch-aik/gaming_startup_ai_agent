import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage(/*name: 'onboarding'*/)
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {},
          child: Text('Sign in anonymously'),
        ),
      ),
    );
  }
}
