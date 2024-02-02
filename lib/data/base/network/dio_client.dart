// import 'package:dio/dio.dart';
// import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
// import 'package:flutter/foundation.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'api_response.dart';
// import 'app_Interceptors.dart';
// import 'dio_base_helper.dart';
//
// class DioClient extends DioBaseHelper {
//   static final DioClient _instance = DioClient._internal();
//   late final Dio _dio;
//   late final String baseURL;
//   late final AppInterceptors interceptors;
//
//   DioClient._internal() {
//     _dio = Dio()
//       ..interceptors.add(interceptors)
//       ..options.baseUrl = baseURL
//       ..options.headers.addAll({'Accept': 'application/json'});
//   }
//
//   factory DioClient(
//       {required String baseURL, required AppInterceptors interceptors}) {
//     _instance.baseURL = baseURL;
//     _instance.interceptors = interceptors;
//     _instance._dio = Dio()
//       ..interceptors.addAll([
//         if (kDebugMode)
//           PrettyDioLogger(
//               requestHeader: true, requestBody: true, responseBody: true),
//         _instance.interceptors,
//         DioCacheInterceptor(options: CacheOptions(store: MemCacheStore())),
//       ])
//       ..options.baseUrl = _instance.baseURL
//       ..options.headers.addAll({'Accept': 'application/json'});
//     return _instance;
//   }
//
//   // @override
//   // Future<NetworkResponse<T>> get<T>(
//   //   String url, {
//   //   Map<String, dynamic>? queryParams,
//   //   Options? options,
//   // }) {
//   //   return _dio.get(url, queryParameters: queryParams, options: options);
//   // }
//
//   @override
//   Future<NetworkResponse<T>> get<T>(
//     String url, {
//     Map<String, dynamic>? queryParams,
//     Options? options,
//   }) async {
//     try {
//       final response = await _dio.get<T>(url,
//           queryParameters: queryParams, options: options);
//       return NetworkResponse.success(response.data as T);
//     } on DioException catch (e) {
//       return NetworkResponse.error(
//           message: e.message, statusCode: e.response?.statusCode);
//     }
//   }
//
//   @override
//   Future<NetworkResponse<T>> post<T>(
//     String url, {
//     dynamic data,
//     Map<String, dynamic>? queryParams,
//     Options? options,
//     bool bypass401Handling = false,
//   }) async{
//     options = (options ?? Options())
//       ..extra = {
//         ...options?.extra ?? {},
//         'bypass401Handling': bypass401Handling,
//       };
//
//     try {
//       final response = await _dio.post<T>(url,
//           queryParameters: queryParams, options: options);
//       return NetworkResponse.success(response.data as T);
//     } on DioException catch (e) {
//       return NetworkResponse.error(
//           message: e.message, statusCode: e.response?.statusCode);
//     }
//
//   }
//
//   @override
//   Future<Response<T>> put<T>(
//     String url, {
//     dynamic data,
//     Map<String, dynamic>? queryParams,
//     Options? options,
//   }) {
//     return _dio.put(url,
//         data: data, queryParameters: queryParams, options: options);
//   }
//
//   @override
//   Future<Response<T>> delete<T>(
//     String url, {
//     dynamic data,
//     Map<String, dynamic>? queryParams,
//     Options? options,
//   }) {
//     return _dio.delete(url,
//         data: data, queryParameters: queryParams, options: options);
//   }
// }
