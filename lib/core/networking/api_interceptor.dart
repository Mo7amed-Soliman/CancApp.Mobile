import 'dart:async';

import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/services/refresh_token_service.dart';
import 'package:canc_app/core/services/token_service.dart';
import 'package:dio/dio.dart';

/// ApiInterceptor is a class that extends Interceptor and adds an authorization header to the request.
class ApiInterceptor extends Interceptor {
  final TokenService _tokenService;

  ApiInterceptor({TokenService? tokenService})
      : _tokenService = tokenService ?? getIt<TokenService>();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenService.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}

/// RefreshTokenInterceptor handles token refresh when a 401 error is received
class RefreshTokenInterceptor extends Interceptor {
  final Dio _dio;
  final RefreshTokenService _refreshTokenService;
  final TokenService _tokenService;

  RefreshTokenInterceptor({
    required Dio dio,
  })  : _dio = dio,
        _refreshTokenService = getIt<RefreshTokenService>(),
        _tokenService = getIt<TokenService>();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 400) {
      final isRefreshed = await _refreshTokenService.refreshToken();

      if (isRefreshed) {
        // Update the failed request with new token
        err.requestOptions.headers['Authorization'] =
            'Bearer ${_tokenService.accessToken}';

        // Retry the failed request
        final retryResponse = await _retry(err.requestOptions);
        return handler.resolve(retryResponse);
      }
    }

    return handler.next(err);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
