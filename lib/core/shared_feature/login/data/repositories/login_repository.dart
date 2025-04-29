import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:canc_app/core/models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../models/login_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserModel>> login({
    required LoginModel loginModel,
  });
}
