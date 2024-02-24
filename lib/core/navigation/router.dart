import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_project_template/config/di/app_initializer.dart';
import 'package:go_router/go_router.dart';
import 'package:xissors/features/auth/screens/onboarding_screen.dart';
import 'package:xissors/features/products/screens/product_screen.dart';

import '../../config/initializer.dart';
import '../../features/auth/screens/login_screen.dart';

GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  observers: [],
  initialLocation: LoginScreen.routeName,
  debugLogDiagnostics: kDebugMode,
  routes: [
    GoRoute(
      path: OnboardingScreen.routeName,
      pageBuilder: (context, state) => buildPage(
        const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: LoginScreen.routeName,
      pageBuilder: (context, state) => buildPage(
        const LoginScreen(),
      ),
    ),
    GoRoute(
      path: ProductScreen.routeName,
      pageBuilder: (context, state) => buildPage(
        const ProductScreen(),
      ),
    ),
  ],
);

Page buildPage(Widget child) {
  return Platform.isIOS
      ? CupertinoPage(child: child)
      : MaterialPage(child: child);
}
