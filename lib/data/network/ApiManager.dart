import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../utilities/toast_util.dart';
import 'ApiResponse.dart';
import 'BaseResponse.dart';
import 'RequestBody.dart';
import 'api_auth.dart';

class ApiManager {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: AppAuth.data.baseUrl,
    connectTimeout: const Duration(seconds: 20),
    sendTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  ));

  static void editDioUrl(String newURl) {
    _dio.options.baseUrl = newURl;
  }

  static Future<ApiResponse> sendRequest({
    required String link,
    RequestBody? body,
    Map<String, dynamic>? queryParams,
    FormData? formData,
    Map<String, dynamic>? headers,
    Method method = Method.POST,
    bool returnWithoutDecode = false,
  }) async {
    headers ??= {"content-type": "application/json"};
    headers.putIfAbsent("Accept", () => "application/json");
    // headers.putIfAbsent("token", () => AppAuth.data.token);
    headers.putIfAbsent(
        "Authorization",
        () =>
            'Bearer 3FFEisviB6ekCKrr7ciJIX5TOtGx3um9j7cQLKVoooVby4U73Woir8yMS78cRzDe');

    try {
      final response = await _dio.request(
        link,
        data: formData ?? body?.getBody(),
        queryParameters: queryParams,
        options: Options(
          method: method.name,
          headers: headers,
        ),
      );

      if (returnWithoutDecode) {
        return ApiResponse(
          statusCode: response.statusCode ?? 0,
          isSuccess: true,
          data: response.data,
          message: "",
        );
      }

      return BaseResponse.extractResponse(response);
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(
        statusCode: -1,
        isSuccess: false,
        message: "Error in connection",
      );
    }
  }

  static ApiResponse _handleError(DioException e) {
    debugPrint('API Error: ${e.response?.statusCode}');
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return ApiResponse(
        statusCode: e.response?.statusCode,
        isSuccess: false,
        message: "Connection timeout",
      );
    }

    switch (e.response?.statusCode) {
      case 401:
        return ApiResponse(
          statusCode: 401,
          isSuccess: false,
          message: "Unauthorized access",
        );
      case 400:
        ToastUtil.showLongToast(message: "Bad request");
        return ApiResponse(
          statusCode: 400,
          isSuccess: false,
          message: "Bad request",
        );
      case 500:
        ToastUtil.showLongToast(message: "Internal server error");
        return ApiResponse(
          statusCode: 500,
          isSuccess: false,
          message: "Internal server error",
        );
      default:
        ToastUtil.showLongToast(message: "Unknown error occurred");
        return ApiResponse(
          statusCode: e.response?.statusCode,
          isSuccess: false,
          message: "Unknown error occurred",
        );
    }
  }
}

enum Method { POST, PUT, GET, DELETE, PATCH, Download }
