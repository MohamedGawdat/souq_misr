import 'package:dio/dio.dart';

import 'api_response.dart';

abstract class DioBaseHelper {
  Future<NetworkResponse<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParams,
    Options? options,
  });

  Future<NetworkResponse<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
    bool bypass401Handling,
  });

  Future<Response<T>> delete<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  });

  Future<Response<T>> put<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  });
}
