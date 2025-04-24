import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/api_constant.dart';
import 'package:canc_app/core/networking/end_point.dart';

class OtpRemoteDataSource {
  final ApiConsumer _apiConsumer;

  OtpRemoteDataSource({
    required ApiConsumer apiConsumer,
  }) : _apiConsumer = apiConsumer;

  Future<void> verifyCode({
    required String email,
    required String code,
  }) async {
    await _apiConsumer.post(
      EndPoint.confirmEmail,
      data: {
        ApiConstant.email: email,
        ApiConstant.otpCode: code,
      },
    );
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
