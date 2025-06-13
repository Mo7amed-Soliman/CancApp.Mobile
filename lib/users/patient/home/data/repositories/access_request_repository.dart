import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:canc_app/users/patient/home/data/models/access_request_model';
import 'package:dartz/dartz.dart';

import '../data_sources/access_request_data_source.dart';

class AccessRequestRepository {
  final AccessRequestDataSource _dataSource;

  AccessRequestRepository(this._dataSource);

  Future<Either<Failure, List<AccessRequestModel>>> getPendingRequests() async {
    try {
      final requests = await _dataSource.getPendingRequests();
      return Right(requests);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> approveAccess({
    required String requestId,
    required bool approve,
  }) async {
    try {
      await _dataSource.approveAccess(
        requestId: requestId,
        approve: approve,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
