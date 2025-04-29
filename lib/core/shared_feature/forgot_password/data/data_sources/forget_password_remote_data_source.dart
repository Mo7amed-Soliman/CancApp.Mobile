import 'package:canc_app/core/networking/api_constant.dart';
import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/end_point.dart';

class ForgetPasswordRemoteDataSource {
  final ApiConsumer _apiConsumer;

  ForgetPasswordRemoteDataSource({
    required ApiConsumer apiConsumer,
  }) : _apiConsumer = apiConsumer;

  Future<void> forgetPassword({
    required String email,
  }) async {
    /// forget password request
    await _apiConsumer.post(
      EndPoint.forgotPassword,
      data: {
        ApiConstant.email: email,
      },
    );
  }

  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    /// forget password request
    await _apiConsumer.post(
      EndPoint.resetPassword,
      data: {
        ApiConstant.email: email,
        ApiConstant.newPassword: newPassword,
      },
    );
  }
}
