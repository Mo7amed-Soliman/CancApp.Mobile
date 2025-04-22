import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:dartz/dartz.dart';
import '../data_sources/forget_password_remote_data_source.dart';

abstract class ForgetPasswordRepository {
  Future<Either<Failure, void>> forgetPassword({required String email});
}

class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  final ForgetPasswordRemoteDataSource _remoteDataSource;

  ForgetPasswordRepositoryImpl({
    required ForgetPasswordRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, void>> forgetPassword({required String email}) async {
    try {
      await _remoteDataSource.forgetPassword(email: email);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
