import 'package:canc_app/core/networking/api_constant.dart';
import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/end_point.dart';

import 'package:canc_app/core/shared_feature/sign_up/data/models/sign_up_model.dart';

class SignUpRemoteDataSource {
  final ApiConsumer _apiConsumer;

  SignUpRemoteDataSource({
    required ApiConsumer apiConsumer,
  }) : _apiConsumer = apiConsumer;

  Future<void> signUp({
    required SignUpModel signUpModel,
  }) async {
    /// sign up request
    await _apiConsumer.post(
      EndPoint.signUp,
      isFromData: true,
      data: {
        'Email': signUpModel.email,
        'Password': signUpModel.password,
        'FullName': signUpModel.name,
        'Address': signUpModel.address,
        'Image': signUpModel.image,
        'UserType': signUpModel.userType,
      },
    );
  }

  Future<void> resendConfirmEmail({
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
