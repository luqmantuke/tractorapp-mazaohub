import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tractorapp/src/core/constants/api_constants.dart';

/// Provider for the API client
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(client: http.Client());
});

/// Common API exception class
class ApiException implements Exception {
  final int statusCode;
  final String message;
  final dynamic data;

  ApiException({
    required this.statusCode,
    required this.message,
    this.data,
  });

  @override
  String toString() => 'ApiException: [$statusCode] $message';
}

class ApiClient {
  final http.Client _client;
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 1);

  ApiClient({
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<ApiResponse> _retryRequest(
    Future<ApiResponse> Function() request,
    int retryCount,
  ) async {
    try {
      return await request();
    } catch (e) {
      if (retryCount < maxRetries) {
        await Future.delayed(retryDelay);
        return _retryRequest(request, retryCount + 1);
      }
      rethrow;
    }
  }

  Future<ApiResponse> postMultipart(
    String endpoint, {
    Map<String, String>? fields,
    Map<String, dynamic>? files,
    int timeoutSeconds = ApiTimeouts.defaultTimeout,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiConstants.baseApiUrl}$endpoint'),
      );

      if (fields != null) {
        request.fields.addAll(fields);
      }

      if (files != null) {
        files.forEach((key, value) {
          if (value is List<int>) {
            request.files.add(
              http.MultipartFile.fromBytes(
                key,
                value,
                filename: key,
              ),
            );
          }
        });
      }

      return _retryRequest(
        () async {
          final streamedResponse = await request.send();
          final response = await http.Response.fromStream(streamedResponse);
          return _handleResponse(response);
        },
        0,
      );
    } catch (e) {
      // log('Multipart request error: $e');
      throw ApiException(
        statusCode: 0,
        message: 'Network error occurred. Please check your connection.',
        data: {'error': e.toString()},
      );
    }
  }

  Future<Map<String, String>> _getHeaders(
      {Map<String, String>? additionalHeaders}) async {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (additionalHeaders != null) ...additionalHeaders,
    };
  }

  Future<ApiResponse> get(String endpoint,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParams,
      int timeoutSeconds = ApiTimeouts.defaultTimeout}) async {
    try {
      final finalHeaders = await _getHeaders(additionalHeaders: headers);

      // Construct the base URL
      final uri = Uri.parse('${ApiConstants.baseApiUrl}$endpoint');

      // Add query parameters if they exist
      final finalUri = queryParams != null
          ? uri.replace(
              queryParameters: queryParams
                  .map((key, value) => MapEntry(key, value.toString())))
          : uri;

      final response = await _client
          .get(
            finalUri,
            headers: finalHeaders,
          )
          .timeout(Duration(seconds: timeoutSeconds));

      return _handleResponse(response);
    } on TimeoutException {
      throw ApiException(
        statusCode: 408,
        message: 'Request timed out. Please try again later.',
        data: {'endpoint': endpoint, 'timeout': timeoutSeconds},
      );
    } catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Network error occurred. Please check your connection.',
        data: {'error': e.toString()},
      );
    }
  }

  Future<ApiResponse> post(String endpoint,
      {Map<String, String>? headers,
      String? body,
      int timeoutSeconds = ApiTimeouts.defaultTimeout}) async {
    try {
      final finalHeaders = await _getHeaders(additionalHeaders: headers);

      final response = await _client
          .post(
            Uri.parse('${ApiConstants.baseApiUrl}$endpoint'),
            headers: finalHeaders,
            body: body,
          )
          .timeout(Duration(seconds: timeoutSeconds));

      log("Response Details: url: ${response.request?.url} status: ${response.statusCode} body: ${response.body}");

      return _handleResponse(response);
    } on TimeoutException {
      throw ApiException(
        statusCode: 408,
        message: 'Request timed out. Please try again later.',
        data: {'endpoint': endpoint, 'timeout': timeoutSeconds},
      );
    } catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Network error occurred. Please check your connection.',
        data: {'error': e.toString()},
      );
    }
  }

  Future<ApiResponse> put(String endpoint,
      {Map<String, String>? headers,
      String? body,
      int timeoutSeconds = ApiTimeouts.defaultTimeout}) async {
    try {
      final finalHeaders = await _getHeaders(additionalHeaders: headers);
      log("[API][PUT] Request: url: ${ApiConstants.baseApiUrl}$endpoint body: $body");

      final response = await _client
          .patch(
            Uri.parse('${ApiConstants.baseApiUrl}$endpoint'),
            headers: finalHeaders,
            body: body,
          )
          .timeout(Duration(seconds: timeoutSeconds));

      log("Response Details: url: ${response.request?.url} status: ${response.statusCode} body: ${response.body}");

      return _handleResponse(response);
    } on TimeoutException {
      throw ApiException(
        statusCode: 408,
        message: 'Request timed out. Please try again later.',
        data: {'endpoint': endpoint, 'timeout': timeoutSeconds},
      );
    } catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Network error occurred. Please check your connection.',
        data: {'error': e.toString()},
      );
    }
  }

  Future<ApiResponse> delete(String endpoint,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParams,
      int timeoutSeconds = ApiTimeouts.defaultTimeout}) async {
    try {
      final finalHeaders = await _getHeaders(additionalHeaders: headers);

      // Construct the base URL
      final uri = Uri.parse('${ApiConstants.baseApiUrl}$endpoint');

      // Add query parameters if they exist
      final finalUri = queryParams != null
          ? uri.replace(
              queryParameters: queryParams
                  .map((key, value) => MapEntry(key, value.toString())))
          : uri;

      final response = await _client
          .delete(
            finalUri,
            headers: finalHeaders,
          )
          .timeout(Duration(seconds: timeoutSeconds));

      log("Response Details: url: ${response.request?.url} status: ${response.statusCode} body: ${response.body}");

      return _handleResponse(response);
    } on TimeoutException {
      throw ApiException(
        statusCode: 408,
        message: 'Request timed out. Please try again later.',
        data: {'endpoint': endpoint, 'timeout': timeoutSeconds},
      );
    } catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Network error occurred. Please check your connection.',
        data: {'error': e.toString()},
      );
    }
  }

  ApiResponse _handleResponse(http.Response response) {
    final contentType = response.headers['content-type'] ?? '';
    final isJsonResponse = contentType.contains('application/json');

    // Success case: 2xx status codes with JSON response
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        isJsonResponse) {
      try {
        final Map<String, dynamic> body = json.decode(response.body);
        return ApiResponse(
          statusCode: response.statusCode,
          data: body,
          error: null,
        );
      } catch (e) {
        // log('Error parsing JSON response: $e');
        throw ApiException(
          statusCode: response.statusCode,
          message: 'Invalid response format',
          data: response.body,
        );
      }
    }

    // Handle API error responses (4xx, 5xx) that return JSON
    if (isJsonResponse) {
      try {
        final Map<String, dynamic> body = json.decode(response.body);
        // Extract error message from the response if available
        final errorMessage =
            body['message'] ?? _getErrorMessage(response.statusCode);

        // log('API error response: $errorMessage');

        throw ApiException(
          statusCode: response.statusCode,
          message: errorMessage,
          data: body,
        );
      } catch (e) {
        if (e is ApiException) {
          rethrow;
        }

        // Failed to parse error JSON
        // log('Failed to parse error response: $e');
        throw ApiException(
          statusCode: response.statusCode,
          message: _getErrorMessage(response.statusCode),
          data: {'rawResponse': response.body},
        );
      }
    }

    // Handle non-JSON responses (like HTML error pages)
    final userFriendlyMessage =
        _getUserFriendlyErrorMessage(response.statusCode);
    // log('Non-JSON response received: ${response.body.substring(0, response.body.length > 100 ? 100 : response.body.length)}...');

    throw ApiException(
      statusCode: response.statusCode,
      message: userFriendlyMessage,
      data: {'rawResponse': response.body},
    );
  }

  String _getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized access. Please login again.';
      case 403:
        return 'You don\'t have permission to access this resource.';
      case 404:
        return 'Resource not found.';
      case 408:
        return 'Request timeout. Please try again.';
      case 500:
        return 'Server error occurred. Please try again later.';
      case 502:
        return 'Bad gateway. The server is temporarily unavailable.';
      case 503:
        return 'Service unavailable. Please try again later.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  String _getUserFriendlyErrorMessage(int statusCode) {
    if (statusCode >= 500) {
      return 'The server is currently experiencing issues. Please try again later.';
    } else if (statusCode >= 400) {
      return 'There was a problem with your request. Please try again.';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}

class ApiResponse {
  final int statusCode;
  final dynamic data;
  final String? error;
  final String? message;
  ApiResponse({
    required this.statusCode,
    required this.data,
    this.error,
    this.message,
  });

  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'data': data,
        'error': error,
      };
}
