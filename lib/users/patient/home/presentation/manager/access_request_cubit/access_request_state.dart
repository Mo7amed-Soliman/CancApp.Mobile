import 'package:canc_app/users/patient/home/data/models/access_request_model';
import 'package:equatable/equatable.dart';

class AccessRequestState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<AccessRequestModel> pendingRequests;

  const AccessRequestState({
    this.isLoading = false,
    this.error,
    this.pendingRequests = const [],
  });

  AccessRequestState copyWith({
    bool? isLoading,
    String? error,
    List<AccessRequestModel>? pendingRequests,
  }) {
    return AccessRequestState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      pendingRequests: pendingRequests ?? this.pendingRequests,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, pendingRequests];
}
