import 'package:canc_app/core/networking/api_constant.dart';
import 'package:canc_app/core/networking/end_point.dart';
import 'package:canc_app/core/networking/refresh_token.dart';
import 'package:canc_app/core/services/token_service.dart';
import 'package:dio/dio.dart';

class RefreshTokenService {
  final Dio _dio;
  final TokenService _tokenService;

  RefreshTokenService({
    required Dio dio,
    required TokenService tokenService,
  })  : _dio = dio,
        _tokenService = tokenService;

  Future<bool> refreshToken() async {
    try {
      final response = await _dio.post(
        EndPoint.refreshToken,
        data: {
          ApiConstant.token: _tokenService.accessToken,
          ApiConstant.refreshToken: _tokenService.refreshToken,
        },
      );

      final refreshTokenResponse = RefreshTokenData.fromJson(response.data);

      await _tokenService.saveTokens(
        accessToken: refreshTokenResponse.accessToken,
        refreshToken: refreshTokenResponse.refreshToken,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
