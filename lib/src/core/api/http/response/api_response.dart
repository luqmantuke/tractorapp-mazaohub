class ApiResponse<T> {
  final String status;
  final String message;
  final T? data;
  final int? statusCode;

  ApiResponse({
    required this.status,
    required this.message,
    this.data,
    this.statusCode,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>)? fromJson) {
    return ApiResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: json['data'] != null && fromJson != null
          ? fromJson(json['data'])
          : null,
    );
  }

  String getUserMessage() {
    if (message.isNotEmpty && status == 'error') {
      return message;
    }

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
    return message;
  }
}
