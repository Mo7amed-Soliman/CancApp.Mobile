import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/users/doctor/profile/data/model/access_request_doctor_model.dart';
import 'package:canc_app/users/doctor/profile/data/repositories/request_access_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'access_requests_doctor_state.dart';

class AccessRequestsDoctorCubit extends Cubit<AccessRequestsDoctorState> {
  final RequestAccessRepository _repository;

  List<AccessRequestDoctorModel> sendRequests = [];
  List<AccessRequestDoctorModel> acceptedRequests = [];

  AccessRequestsDoctorCubit(this._repository)
      : super(AccessRequestsDoctorInitial());

  Future<void> loadAccessRequests() async {
    emit(AccessRequestsDoctorLoading());

    final sendRequestsResult = await _repository.getAllPatient();
    sendRequestsResult.fold(
      (failure) {
        emit(AccessRequestsDoctorError(failure.errorMessage));
      },
      (users) {
        sendRequests = users;
        emit(const AccessRequestsDoctorLoaded());
      },
    );

    // final acceptedRequests = await _repository.getAllAcceptedRequests();
    // acceptedRequests.fold(
    //   (failure) {
    //     emit(AccessRequestsDoctorError(failure.errorMessage));
    //   },
    //   (response) {
    //     emit(AccessRequestsDoctorLoaded(
    //       sendRequests: [],
    //       acceptedRequests: response,
    //     ));
    //   },
    // );
  }

  Future<void> sendAccess({
    required String patientId,
    required String doctorId,
  }) async {
    final result = await _repository.sendAccess(
      patientId: patientId,
      doctorId: doctorId,
    );

    result.fold(
      (failure) {
        emit(AccessRequestsDoctorError(failure.errorMessage));
      },
      (_) {
        botTextToast('Request sent successfully',
            color: AppColors.primaryColor);
      },
    );
  }
}
