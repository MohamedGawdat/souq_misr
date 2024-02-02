import 'package:dio/dio.dart';

class ApiResponse {
  int? statusCode;
  Map<String, dynamic>? data;
  bool isSuccess;
  String? message;

  ApiResponse({
    required this.statusCode,
    this.data,
    required this.isSuccess,
    this.message,
  });

  factory ApiResponse.fromResponse(Response response) {
    return ApiResponse(
      statusCode: response.statusCode,
      data: response.data is Map<String, dynamic> ? response.data : null,
      isSuccess: response.statusCode == 200,
      message: response.statusMessage,
    );
  }

  factory ApiResponse.fromError(DioException error) {
    String message;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout";
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout";
        break;
      case DioExceptionType.badResponse:
        message = "Received invalid status code: ${error.response?.statusCode}";
        break;
      case DioExceptionType.cancel:
        message = "Request was cancelled";
        break;
      default:
        message = "Unexpected error occurred";
    }
    return ApiResponse(
      statusCode: error.response?.statusCode,
      isSuccess: false,
      message: message,
    );
  }
}
