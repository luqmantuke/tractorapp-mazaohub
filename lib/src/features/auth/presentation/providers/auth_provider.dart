import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tractorapp/src/core/providers/shared_preferences/shared_preference_provider.dart';
import '../../data/auth_data.dart';

// Auth states
enum AuthStatus { initial, loading, error, success, loggedIn }

class AuthState {
  final AuthStatus status;
  final String? error;
  final UserType? userType;

  const AuthState({
    this.status = AuthStatus.initial,
    this.error,
    this.userType,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? error,
    UserType? userType,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: error,
      userType: userType ?? this.userType,
    );
  }
}

class AuthNotifier extends AsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async {
    return const AuthState();
  }

  Future<void> login(String emailOrPhone, String password) async {
    state = const AsyncValue.loading();
    final result = await authenticate(emailOrPhone, password);
    if (result.success) {
      // Store login state and user type in SharedPreferences
      final prefs = ref.read(sharedPreferenceInstanceProvider);
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('user_type', result.userType.toString());
      await prefs.setString('user_name', result.name ?? '');
      await prefs.setString('user_email', emailOrPhone);
      state = AsyncValue.data(AuthState(
        status: AuthStatus.success,
        userType: result.userType,
      ));
    } else {
      state = AsyncValue.data(AuthState(
        status: AuthStatus.error,
        error: result.error,
      ));
    }
  }

  void reset() {
    state = const AsyncValue.data(AuthState(status: AuthStatus.initial));
  }
}

final authProvider =
    AsyncNotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
