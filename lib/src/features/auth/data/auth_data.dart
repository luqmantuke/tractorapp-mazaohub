enum UserType { mechanicalOwner, farmer, agent }

class DummyUser {
  final String emailOrPhone;
  final String password;
  final String name;
  final UserType userType;

  DummyUser({
    required this.emailOrPhone,
    required this.password,
    required this.userType,
    required this.name,
  });
}

final List<DummyUser> dummyUsers = [
  DummyUser(
      emailOrPhone: 'mechanicalowner@mazaohub.com',
      password: 'password123',
      name: 'Alex Ally',
      userType: UserType.mechanicalOwner),
  DummyUser(
      emailOrPhone: 'farmer@mazaohub.com',
      password: 'password123',
      name: 'Charles Mwambi',
      userType: UserType.farmer),
  DummyUser(
      emailOrPhone: 'agent@mazaohub.com',
      password: 'password123',
      name: 'Julius John',
      userType: UserType.agent),
];

class AuthResult {
  final bool success;
  final String? error;
  final UserType? userType;
  final String? name;

  AuthResult({
    required this.success,
    this.error,
    this.userType,
    this.name,
  });
}

Future<AuthResult> authenticate(String emailOrPhone, String password) async {
  await Future.delayed(const Duration(seconds: 1));
  final user = dummyUsers.firstWhere(
    (u) => u.emailOrPhone == emailOrPhone && u.password == password,
    orElse: () => DummyUser(
        emailOrPhone: '', password: '', userType: UserType.farmer, name: ''),
  );
  if (user.emailOrPhone.isEmpty) {
    return AuthResult(success: false, error: 'Invalid credentials');
  }
  return AuthResult(success: true, userType: user.userType, name: user.name);
}
