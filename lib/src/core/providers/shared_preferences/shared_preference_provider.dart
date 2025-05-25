import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferenceInstanceProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
      'sharedPreferenceInstanceProvider must be overridden in the ProviderScope');
});

final isLoggedInPreferenceProvider = Provider<bool>((ref) {
  final sharedPreferences = ref.watch(sharedPreferenceInstanceProvider);
  final isLoggedIn = sharedPreferences.getBool('is_logged_in') ?? false;
  return isLoggedIn;
});

final userNamePreferenceProvider = Provider<String>((ref) {
  final sharedPreferences = ref.watch(sharedPreferenceInstanceProvider);
  final userName = sharedPreferences.getString('user_name') ?? '';
  return userName;
});

final userIdPreferenceProvider = Provider<String>((ref) {
  final sharedPreferences = ref.watch(sharedPreferenceInstanceProvider);
  final userId = sharedPreferences.getString('user_id') ?? '';
  return userId;
});

final tokenPreferenceProvider = Provider<String>((ref) {
  final sharedPreferences = ref.watch(sharedPreferenceInstanceProvider);
  final token = sharedPreferences.getString('token') ?? '';
  log("[TOKEN]: token: $token");
  return token;
});

final phoneNumberPreferenceProvider = Provider<String>((ref) {
  final sharedPreferences = ref.watch(sharedPreferenceInstanceProvider);
  final phoneNumber = sharedPreferences.getString('phone_number') ?? '';
  return phoneNumber;
});
