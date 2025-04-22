import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:canc_app/core/shared_feature/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:canc_app/core/shared_feature/sign_up/data/models/sign_up_model.dart';
import 'package:dartz/dartz.dart';

import 'sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpRemoteDataSource _signUpDataSource;

  SignUpRepositoryImpl({
    required SignUpRemoteDataSource signUpDataSource,
  }) : _signUpDataSource = signUpDataSource;

  @override
  Future<Either<Failure, void>> signUp({
    required SignUpModel signUpModel,
  }) async {
    try {
      await _signUpDataSource.signUp(
        signUpModel: signUpModel,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resendConfirmEmail(
      {required String email}) async {
    try {
      await _signUpDataSource.resendConfirmEmail(email: email);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
