import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tractorapp/src/core/constants/images/images.dart';
import 'package:tractorapp/src/core/providers/shared_preferences/shared_preference_provider.dart';

class AuthenticationWrapper extends ConsumerStatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  ConsumerState<AuthenticationWrapper> createState() =>
      _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends ConsumerState<AuthenticationWrapper> {
  Future<void> initializeApp() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    final isLoggedIn = ref.read(isLoggedInPreferenceProvider);
    final prefs = ref.read(sharedPreferenceInstanceProvider);
    final userTypeString = prefs.getString('user_type');
    if (isLoggedIn && userTypeString != null) {
      if (userTypeString.contains('mechanicalOwner')) {
        context.go('/mechanical-owner-home');
      } else if (userTypeString.contains('farmer')) {
        context.go('/farmer-home');
      } else if (userTypeString.contains('agent')) {
        context.go('/agent-home');
      } else {
        context.go('/login');
      }
    } else {
      context.go('/onboarding');
    }
  }

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    // Always show the splash while initializing
    return Scaffold(
      body: Center(
        child: Image.asset(AssetImages.logo),
      ),
    );
  }
}
