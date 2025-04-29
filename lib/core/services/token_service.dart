import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/secure_cache_helper.dart';
import 'package:canc_app/core/networking/api_constant.dart';

class TokenService {
  final SecureCacheHelper _secureCacheHelper;
  TokenService() : _secureCacheHelper = getIt<SecureCacheHelper>();

  Future<String?> get accessToken async {
    return await _secureCacheHelper.getData(key: ApiConstant.token);
  }

  Future<String?> get refreshToken async {
    return await _secureCacheHelper.getData(key: ApiConstant.refreshToken);
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _secureCacheHelper.saveData(
      key: ApiConstant.token,
      value: accessToken,
    );
    await _secureCacheHelper.saveData(
      key: ApiConstant.refreshToken,
      value: refreshToken,
    );
  }

  Future<void> clearTokens() async {
    await _secureCacheHelper.removeData(key: ApiConstant.token);
    await _secureCacheHelper.removeData(key: ApiConstant.refreshToken);
  }
}
