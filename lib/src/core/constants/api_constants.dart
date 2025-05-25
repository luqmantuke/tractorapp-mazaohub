/// API Constants class that holds all API-related constants
class ApiConstants {
  /// Private constructor to prevent instantiation
  const ApiConstants._();

  /// Base server URL for API endpoints
  static const String baseServerUrl = 'http://192.168.76.163:3080';

  /// API version
  static const String apiVersion = 'v1';

  /// Base API URL combining base server URL and API version
  static String get baseApiUrl => baseServerUrl;

  /// Default timeout duration for API requests in milliseconds
  static const int timeoutDuration = 30000;

  /// Default headers for API requests
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// API endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh-token';
}

/// API request timeouts
class ApiTimeouts {
  /// Default timeout duration in seconds
  static const int defaultTimeout = 30;

  /// Short timeout for quick operations like status checks
  static const int shortTimeout = 10;

  /// Long timeout for operations that might take longer
  static const int longTimeout = 60;
}
