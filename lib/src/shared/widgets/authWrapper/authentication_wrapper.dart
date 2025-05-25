import 'dart:async';

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
  Future<void> initializeApp() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      context.goNamed('onboarding');
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
