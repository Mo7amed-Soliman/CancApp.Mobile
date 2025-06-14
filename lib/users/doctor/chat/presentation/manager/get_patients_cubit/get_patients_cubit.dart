import 'package:canc_app/users/doctor/chat/data/repositories/get_users_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'get_patients_state.dart';

class GetPatientsCubit extends Cubit<GetPatientsState> {
  final GetUsersRepository _getUsersRepository;

  GetPatientsCubit(this._getUsersRepository)
      : super(const GetPatientsInitial());

  Future<void> getPatients() async {
    emit(const GetPatientsLoading());
    final result = await _getUsersRepository.getpatients();
    result.fold(
      (failure) => emit(GetPatientsError(failure.errorMessage)),
      (patients) => emit(GetPatientsSuccess(patients)),
    );
  }
}
