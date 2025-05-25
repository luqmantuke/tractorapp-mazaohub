import 'dart:developer';

class ApiException implements Exception {
  final String message;
  final String userMessage;
  final int? statusCode;

  ApiException(this.message, {this.statusCode, String? userMessage})
      : userMessage =
            userMessage ?? 'Something went wrong. Please try again later.';

  String getUserMessage() {
    log("[API EXCEPTION]: Message: $message Status Code: $statusCode User Message: $userMessage");

    if (message.contains('SocketException') ||
        message.contains('Connection refused')) {
      return 'Unable to connect to server. Please check your connection.';
    }
    if (statusCode == 401 || statusCode == 403) {
      return 'Session expired. Please login again.';
    }
    if (statusCode == 404) {
      return 'Service unavailable. Please try again later.';
    }
    if (statusCode == 500) {
      return 'Server error. Please try again later.';
    }
    return userMessage;
  }

  @override
  String toString() => message;
}
