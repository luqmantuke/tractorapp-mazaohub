// private navigators
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tractorapp/src/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:tractorapp/src/shared/widgets/authWrapper/authentication_wrapper.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/authenticationWrapper',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    // Add observer to track screen views for session replay
    routes: [
      GoRoute(
        path: '/authenticationWrapper',
        builder: (context, state) => const AuthenticationWrapper(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
    ],
  );
});
