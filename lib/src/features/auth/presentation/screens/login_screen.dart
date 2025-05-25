import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tractorapp/src/core/constants/colors.dart';
import 'package:tractorapp/src/core/constants/images/images.dart';
import 'package:tractorapp/src/features/auth/presentation/providers/auth_provider.dart';
import 'package:tractorapp/src/shared/widgets/buttons/custombuttons.dart';
import 'package:tractorapp/src/shared/widgets/errors/error_widget.dart';
import '../../data/auth_data.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() {
    ref.read(authProvider.notifier).login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
  }

  void _handleRetry() {
    ref.read(authProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    final authAsync = ref.watch(authProvider);

    ref.listen<AsyncValue<AuthState>>(authProvider, (prev, next) {
      next.whenOrNull(
        data: (state) {
          if (state.status == AuthStatus.success) {
            if (state.userType == UserType.mechanicalOwner) {
              context.go('/mechanical-owner-home');
            } else if (state.userType == UserType.farmer) {
              context.go('/farmer-home');
            } else if (state.userType == UserType.agent) {
              context.go('/agent-home');
            }
          }
        },
      );
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 6.h),
                Image.asset(
                  AssetImages.logo,
                  height: 10.h,
                ),
                SizedBox(height: 3.h),
                Text(
                  'Welcome MazaoHub',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen,
                        fontSize: 22.sp,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 1.h),
                Text(
                  'Login to continue',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                authAsync.when(
                  loading: () => Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: const CircularProgressIndicator(),
                  ),
                  error: (err, stack) => Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: InlineErrorWidget(
                      message: err.toString(),
                      onRetry: _handleRetry,
                    ),
                  ),
                  data: (authState) => authState.status == AuthStatus.error &&
                          authState.error != null
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: InlineErrorWidget(
                            message: authState.error!,
                            onRetry: _handleRetry,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email or phone',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                  ),
                ),
                SizedBox(height: 1.h),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email or phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.grey),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  ),
                ),
                SizedBox(height: 2.5.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                  ),
                ),
                SizedBox(height: 1.h),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.grey),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  ),
                ),
                SizedBox(height: 1.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft,
                    ),
                    child: Text(
                      'Forgot your password? Reset Here',
                      style: TextStyle(
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                authAsync.maybeWhen(
                  loading: () => const SizedBox.shrink(),
                  orElse: () => CustomButton(
                    text: 'Log in',
                    onPressed: _handleLogin,
                    color: AppColors.primaryGreen,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 3.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
