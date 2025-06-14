import 'package:canc_app/core/models/user_model.dart';
import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:canc_app/users/doctor/chat/data/datasources/get_users_data_sources.dart';
import 'package:dartz/dartz.dart';

class GetUsersRepository {
  final GetUsersDataSource getUsersDataSource;

  GetUsersRepository(this.getUsersDataSource);

  Future<Either<Failure, List<UserModel>>> getpatients() async {
    try {
      final response = await getUsersDataSource.getpatients();
      return Right(response);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
