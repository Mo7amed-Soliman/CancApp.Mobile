import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:dartz/dartz.dart';

abstract class OtpRepository {
  Future<Either<Failure, void>> verifyCode({
    required String userId,
    required String code,
  });

  Future<Either<Failure, void>> resendCode({
    required String email,
  });
}
