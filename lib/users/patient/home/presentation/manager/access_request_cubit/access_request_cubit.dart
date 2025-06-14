import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/access_request_repository.dart';
import 'access_request_state.dart';

class AccessRequestCubit extends Cubit<AccessRequestState> {
  final AccessRequestRepository _repository;

  AccessRequestCubit(this._repository) : super(const AccessRequestState());

  Future<void> loadPendingRequests() async {
    try {
      emit(state.copyWith(isLoading: true, error: null));
      final result = await _repository.getPendingRequests();
      result.fold(
        (failure) {
          emit(state.copyWith(error: failure.errorMessage));
        },
        (requests) {
          emit(state.copyWith(pendingRequests: requests));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> handleAccessRequest({
    required String requestId,
    required bool approve,
  }) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));
      final result = await _repository.approveAccess(
        requestId: requestId,
        approve: approve,
      );
      result.fold(
        (failure) {
          emit(state.copyWith(error: failure.errorMessage));
        },
        (_) {
          emit(state.copyWith(
            isLoading: false,
            error: null,
            pendingRequests: state.pendingRequests
                .where((request) => request.id != requestId)
                .toList(),
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}
