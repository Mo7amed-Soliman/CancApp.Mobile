import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:canc_app/core/shared_feature/otp/data/data_sources/otp_remote_data_source.dart';
import 'package:dartz/dartz.dart';

import 'otp_repository.dart';

class OtpRepositoryImpl implements OtpRepository {
  final OtpRemoteDataSource _otpRemoteDataSource;

  OtpRepositoryImpl({
    required OtpRemoteDataSource otpRemoteDataSource,
  }) : _otpRemoteDataSource = otpRemoteDataSource;

  @override
  Future<Either<Failure, void>> verifyCode({
    required String email,
    required String code,
  }) async {
    try {
      await _otpRemoteDataSource.verifyCode(
        email: email,
        code: code,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resendCode({
    required String email,
  }) async {
    try {
      await _otpRemoteDataSource.resendCode(
        email: email,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyCodeForgetPassword({
    required String email,
    required String code,
  }) async {
    try {
      await _otpRemoteDataSource.verifyCodeForgetPassword(
        email: email,
        code: code,
      );
      return const Right(null);
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
      await _otpRemoteDataSource.saveFcmToken(token: token);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
