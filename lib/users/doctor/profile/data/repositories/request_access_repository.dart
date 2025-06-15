import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:canc_app/users/doctor/profile/data/data_sources/request_access_data_source.dart';
import 'package:canc_app/users/doctor/profile/data/model/access_request_doctor_model.dart';
import 'package:canc_app/users/doctor/profile/data/model/record_doctor_model.dart';
import 'package:dartz/dartz.dart';

class RequestAccessRepository {
  final RequestAccessDataSource _dataSource;

  RequestAccessRepository(this._dataSource);

  Future<Either<Failure, void>> sendAccess({
    required String patientId,
    required String doctorId,
  }) async {
    try {
      await _dataSource.sendAccess(
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

  Future<Either<Failure, List<AccessRequestDoctorModel>>>
      getAllPatient() async {
    try {
      final response = await _dataSource.getAllPatient();
      return Right(response);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, List<RecordDoctorModel>>> getRecordsForPatient({
    required String patientId,
    required String doctorId,
  }) async {
    try {
      final records = await _dataSource.getRecordsForPatient(
        patientId: patientId,
        doctorId: doctorId,
      );
      return Right(records);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, List<AccessRequestDoctorModel>>>
      getAcceptedPatients() async {
    try {
      final patients = await _dataSource.getAcceptedPatients();
      return Right(patients);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
