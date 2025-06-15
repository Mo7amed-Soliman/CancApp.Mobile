import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:canc_app/core/shared_feature/login/data/data_sources/login_remote_data_source.dart';
import 'package:dartz/dartz.dart';

import '../models/login_model.dart';
import '../../../../models/user_model.dart';
import 'login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource _loginDataSource;

  LoginRepositoryImpl({
    required LoginRemoteDataSource loginDataSource,
  }) : _loginDataSource = loginDataSource;

  @override
  Future<Either<Failure, UserModel>> login({
    required LoginModel loginModel,
  }) async {
    try {
      final userModel = await _loginDataSource.login(
        loginModel: loginModel,
      );

      return Right(userModel);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveFcmToken({
    required String token,
  }) async {
    try {
      await _loginDataSource.saveFcmToken(token: token);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
