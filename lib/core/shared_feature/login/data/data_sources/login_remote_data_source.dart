import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/networking/api_constant.dart';
import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/end_point.dart';
import 'package:canc_app/core/services/token_service.dart';
import 'package:canc_app/core/services/user_service.dart';
import 'package:canc_app/core/shared_feature/login/data/models/login_model.dart';
import 'package:canc_app/core/models/user_model.dart';

class LoginRemoteDataSource {
  final ApiConsumer _apiConsumer;
  final TokenService _tokenService;
  final UserService _userService;

  LoginRemoteDataSource({
    required ApiConsumer apiConsumer,
  })  : _apiConsumer = apiConsumer,
        _tokenService = getIt<TokenService>(),
        _userService = getIt<UserService>();

  Future<UserModel> login({
    required LoginModel loginModel,
  }) async {
    /// login request
    final response = await _apiConsumer.post(
      EndPoint.login,
      data: {
        ApiConstant.email: loginModel.email,
        ApiConstant.password: loginModel.password,
      },
    );

    /// save tokens automatically
    await _tokenService.saveTokens(
      accessToken: response[ApiConstant.token],
      refreshToken: response[ApiConstant.refreshToken],
    );

    /// save user data
    final userModel = UserModel.fromJson(response);
    await _userService.saveUser(userModel);

    return userModel;
  }
}
