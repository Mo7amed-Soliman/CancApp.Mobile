import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:canc_app/core/shared_feature/change_password/data/datasources/change_password_remote_data_source.dart';
import 'package:dartz/dartz.dart';

class ChangePasswordRepository {
  final ChangePasswordRemoteDataSource remoteDataSource;

  ChangePasswordRepository({
    required this.remoteDataSource,
  });

  Future<Either<Failure, void>> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    try {
      await remoteDataSource.changePassword(
        oldPassword,
        newPassword,
      );

      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
