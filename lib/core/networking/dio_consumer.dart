import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/api_interceptor.dart';
import 'package:canc_app/core/networking/end_point.dart';
import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:dio/dio.dart';

/// DioConsumer is a class that extends ApiConsumer and uses Dio to make network requests.
class DioConsumer extends ApiConsumer {
  final Dio _dio;

  DioConsumer({required Dio dio}) : _dio = dio {
    _dio.options.baseUrl = EndPoint.apiBaseUrl;
    _dio.interceptors.add(ApiInterceptor());
    _dio.interceptors.add(RefreshTokenInterceptor(dio: _dio));
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }

  @override
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
      );

      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }
}
