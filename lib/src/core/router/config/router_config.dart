// private navigators
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tractorapp/src/features/auth/presentation/screens/login_screen.dart';
import 'package:tractorapp/src/features/homescreen/presentation/screens/farmer_machine_details/farmer_machine_details_screen.dart';
import 'package:tractorapp/src/features/homescreen/presentation/screens/farmer_search/farmer_search_screen.dart';
import 'package:tractorapp/src/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:tractorapp/src/shared/widgets/authWrapper/authentication_wrapper.dart';
import 'package:tractorapp/src/features/homescreen/presentation/screens/mechanical_owner_home_screen.dart';
import 'package:tractorapp/src/features/homescreen/presentation/screens/farmer_home_screen.dart';
import 'package:tractorapp/src/features/homescreen/presentation/screens/agent_home_screen.dart';

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
        name: 'authenticationWrapper',
        builder: (context, state) => const AuthenticationWrapper(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/mechanical-owner-home',
        name: 'mechanical-owner-home',
        builder: (context, state) => const MechanicalOwnerHomeScreen(),
      ),
      GoRoute(
        path: '/farmer-home',
        name: 'farmer-home',
        builder: (context, state) => const FarmerHomeScreen(),
      ),
      GoRoute(
        path: '/agent-home',
        name: 'agent-home',
        builder: (context, state) => const AgentHomeScreen(),
      ),
      GoRoute(
        path: '/farmer-search',
        name: 'farmer-search',
        builder: (context, state) => const FarmerSearchScreen(),
      ),
      GoRoute(
        path: '/farmer-machine-details',
        name: 'farmer-machine-details',
        builder: (context, state) => FarmerMachineDetailsScreen(
          machine: state.extra as Map<String, dynamic>,
        ),
      ),
    ],
  );
});
