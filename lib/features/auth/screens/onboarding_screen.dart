import 'package:flutter/material.dart';
import 'package:xissors/core/navigation/navigator.dart';
import 'package:xissors/features/auth/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  void login() {
    context.navigator.push(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: login,
        child: const Icon(Icons.add),
      ),
    );
  }
}
