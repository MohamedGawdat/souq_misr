import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  AppInterceptors(
    this.onRequestHeader,
    this.onErrorCallback,
  );

  final Future<Map<String, dynamic>> Function()? onRequestHeader;
  final Future<void> Function(DioException)? onErrorCallback;

  @override
  FutureOr<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (onRequestHeader != null) {
      final header = await onRequestHeader?.call();
      if (header != null) {
        options.headers.addAll(header);
      }
    }
    return handler.next(options);
  }

  @override
  FutureOr<dynamic> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.requestOptions.extra['bypass401Handling'] == true) {
      return handler.next(err);
    }
    await onErrorCallback?.call(err);
    if (err.response?.statusCode == 401) {
      _handleUnauthorized();
    }
    log(err.message ?? 'No Error To Show', error: err);
    return handler.next(err);
  }

  void _handleUnauthorized() {}
}
