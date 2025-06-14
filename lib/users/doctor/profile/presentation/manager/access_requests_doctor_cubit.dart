import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/users/doctor/profile/data/repositories/request_access_repository.dart';
import 'package:canc_app/users/doctor/profile/data/model/access_request_doctor_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'access_requests_doctor_state.dart';

class AccessRequestsDoctorCubit extends Cubit<AccessRequestsDoctorState> {
  final RequestAccessRepository _repository;

  AccessRequestsDoctorCubit(this._repository)
      : super(AccessRequestsDoctorInitial());

  Future<void> loadAccessRequests() async {
    emit(AccessRequestsDoctorLoading());
    try {
      // TODO: Implement API call to get requests
      // For now using mock data
      final sendRequests = [
        AccessRequestDoctorModel(
          name: 'Omar Ahmed',
          address: '7529 E. Zhraa Almaadi 125 St.',
          image: 'https://randomuser.me/api/portraits/men/1.jpg',
          userId: '1',
        ),
        AccessRequestDoctorModel(
          name: 'Omar Ahmed',
          address: '7529 E. Zhraa Almaadi 125 St.',
          image: 'https://randomuser.me/api/portraits/men/2.jpg',
          userId: '2',
        ),
      ];

      final acceptedRequests = [
        AccessRequestDoctorModel(
          name: 'Omar Ahmed',
          address: '7529 E. Zhraa Almaadi 125 St.',
          image: 'https://randomuser.me/api/portraits/men/3.jpg',
          userId: '3',
        ),
        AccessRequestDoctorModel(
          name: 'Omar Ahmed',
          address: '7529 E. Zhraa Almaadi 125 St.',
          image: 'https://randomuser.me/api/portraits/men/4.jpg',
          userId: '4',
        ),
      ];

      emit(AccessRequestsDoctorLoaded(
        sendRequests: sendRequests,
        acceptedRequests: acceptedRequests,
      ));
    } catch (e) {
      emit(AccessRequestsDoctorError(e.toString()));
    }
  }

  Future<void> requestAccess({
    required String patientId,
    required String doctorId,
  }) async {
    final result = await _repository.requestAccess(
      patientId: patientId,
      doctorId: doctorId,
    );

    result.fold(
      (failure) {
        emit(AccessRequestsDoctorError(failure.errorMessage));
      },
      (_) {
        showSuccessToast('Request sent successfully');
        // loadAccessRequests(); // Reload the requests after sending
      },
    );
  }
}
