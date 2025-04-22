import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:canc_app/core/shared_feature/sign_up/data/models/sign_up_model.dart';
import 'package:dartz/dartz.dart';

abstract class SignUpRepository {
  Future<Either<Failure, void>> signUp({
    required SignUpModel signUpModel,
  });
  Future<Either<Failure, void>> resendConfirmEmail({
    required String email,
  });
}
