import 'package:canc_app/users/doctor/profile/data/repositories/request_access_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'access_record_type_doctor_state.dart';

class AccessRecordTypeDoctorCubit extends Cubit<AccessRecordTypeDoctorState> {
  final RequestAccessRepository _repository;

  AccessRecordTypeDoctorCubit({
    required RequestAccessRepository repository,
  })  : _repository = repository,
        super(const AccessRecordTypeDoctorInitial());

  Future<void> loadRecords(
    String patientId,
    String recordType,
    String doctorId,
  ) async {
    emit(const AccessRecordTypeDoctorLoading());
    try {
      final result = await _repository.getRecordsForPatient(
        patientId: patientId,
        doctorId: doctorId,
      );
      result.fold(
        (failure) => emit(AccessRecordTypeDoctorError(failure.errorMessage)),
        (records) {
          // Filter records by type
          final filteredRecords = records
              .where((record) => record.recordType == recordType)
              .toList();
          emit(AccessRecordTypeDoctorSuccess(filteredRecords));
        },
      );
    } catch (e) {
      emit(AccessRecordTypeDoctorError(e.toString()));
    }
  }
}
