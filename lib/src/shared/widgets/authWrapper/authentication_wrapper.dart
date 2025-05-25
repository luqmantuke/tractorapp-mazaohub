import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tractorapp/src/core/constants/images/images.dart';

class AuthenticationWrapper extends ConsumerStatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  ConsumerState<AuthenticationWrapper> createState() =>
      _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends ConsumerState<AuthenticationWrapper> {
  bool _isInitialized = false;

  Future<void> initializeApp() async {
    try {
      // Initialize shared preferences
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() => _isInitialized = true);
        context.goNamed('onboarding');
      });
    } catch (e) {
      log("[AUTH]: Error during initialization: $e");
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          setState(() => _isInitialized = true);
          context.goNamed('onboarding');
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        body: Center(
          child: Image.asset(AssetImages.logo),
        ),
      );
    }
    return const Scaffold();
  }
}
