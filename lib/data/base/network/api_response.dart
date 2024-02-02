import 'package:dio/dio.dart';

class NetworkResponse<T> {
  final T? data;
  final String? message;
  final int? statusCode;

  NetworkResponse({
    this.data,
    this.message,
    this.statusCode,
  });
  bool get isSuccess =>
      statusCode != null && statusCode! >= 200 && statusCode! < 300;

  factory NetworkResponse.success(T data) {
    return NetworkResponse(data: data, statusCode: 200);
  }
  factory NetworkResponse.error({String? message, int? statusCode}) {
    return NetworkResponse(message: message, statusCode: statusCode);
  }
// we can use this approach if we will handle show toast errors like "Connection timeout"
  // factory NetworkResponse.fromError(DioException error) {
  //   String message;
  //   switch (error.type) {
  //     case DioExceptionType.connectionTimeout:
  //       message = "Connection timeout";
  //       break;
  //     case DioExceptionType.sendTimeout:
  //       message = "Send timeout";
  //       break;
  //     case DioExceptionType.receiveTimeout:
  //       message = "Receive timeout";
  //       break;
  //     case DioExceptionType.badResponse:
  //       message = "Received invalid status code: ${error.response?.statusCode}";
  //       break;
  //     case DioExceptionType.cancel:
  //       message = "Request was cancelled";
  //       break;
  //     default:
  //       message = "Unexpected error occurred";
  //   }
  //   return NetworkResponse(
  //     statusCode: error.response?.statusCode,
  //     message: message,
  //   );
  // }
}
