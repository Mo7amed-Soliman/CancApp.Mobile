import 'package:canc_app/core/models/user_model.dart';
import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:dartz/dartz.dart';

import '../datasources/get_available_users_data_source.dart';

class GetAvailableUsersRepository {
  final GetAvailableUsersDataSource _dataSource;

  GetAvailableUsersRepository(this._dataSource);

  Future<Either<Failure, List<UserModel>>> getUsers(int categoryIndex) async {
    try {
      final response = await _dataSource.getUsers(categoryIndex);
      return Right(response);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
