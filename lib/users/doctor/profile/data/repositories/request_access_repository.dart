import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:canc_app/users/doctor/profile/data/data_sources/request_access_data_source.dart';
import 'package:dartz/dartz.dart';

class RequestAccessRepository {
  final RequestAccessDataSource _dataSource;

  RequestAccessRepository(this._dataSource);

  Future<Either<Failure, void>> requestAccess({
    required String patientId,
    required String doctorId,
  }) async {
    try {
      await _dataSource.requestAccess(
        patientId: patientId,
        doctorId: doctorId,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
