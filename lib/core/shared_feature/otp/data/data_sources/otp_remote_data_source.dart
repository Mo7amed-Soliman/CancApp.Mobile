import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/models/user_model.dart';
import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/api_constant.dart';
import 'package:canc_app/core/networking/end_point.dart';
import 'package:canc_app/core/services/token_service.dart';

class OtpRemoteDataSource {
  final ApiConsumer _apiConsumer;
  final TokenService _tokenService;
  OtpRemoteDataSource({
    required ApiConsumer apiConsumer,
  })  : _apiConsumer = apiConsumer,
        _tokenService = getIt<TokenService>();

  Future<void> verifyCode({
    required String email,
    required String code,
  }) async {
    final response = await _apiConsumer.post(
      EndPoint.confirmEmail,
      data: {
        ApiConstant.email: email,
        ApiConstant.otpCode: code,
      },
    );

    /// save tokens automatically
    await _tokenService.saveTokens(
      accessToken: response[ApiConstant.token],
      refreshToken: response[ApiConstant.refreshToken],
    );

    /// save user data
    final userModel = UserModel.fromJson(response);
    await UserCacheHelper.saveUser(userModel);
  }

  Future<void> resendCode({
    required String email,
  }) async {
    await _apiConsumer.post(
      EndPoint.resendConfirmEmail,
      data: {
        ApiConstant.email: email,
      },
    );
  }
}
