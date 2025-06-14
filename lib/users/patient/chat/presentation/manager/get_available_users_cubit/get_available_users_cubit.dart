import 'package:canc_app/users/patient/chat/data/repositories/get_available_users_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'get_available_users_state.dart';

class GetAvailableUsersCubit extends Cubit<GetAvailableUsersState> {
  final GetAvailableUsersRepository _repository;

  GetAvailableUsersCubit(this._repository)
      : super(const GetAvailableUsersInitial());

  Future<void> getUsers(int categoryIndex) async {
    emit(const GetAvailableUsersLoading());
    final result = await _repository.getUsers(categoryIndex);
    result.fold(
      (failure) => emit(GetAvailableUsersError(failure.errorMessage)),
      (users) => emit(GetAvailableUsersSuccess(users)),
    );
  }
}
