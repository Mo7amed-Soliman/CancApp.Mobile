import 'package:canc_app/users/doctor/profile/data/model/access_request_doctor_model.dart';
import 'package:equatable/equatable.dart';

abstract class AccessRequestsDoctorState extends Equatable {
  const AccessRequestsDoctorState();

  @override
  List<Object?> get props => [];
}

class AccessRequestsDoctorInitial extends AccessRequestsDoctorState {}

class AccessRequestsDoctorLoading extends AccessRequestsDoctorState {}

class AccessRequestsDoctorLoaded extends AccessRequestsDoctorState {
  final List<AccessRequestDoctorModel>? sendRequests;
  final List<AccessRequestDoctorModel>? acceptedRequests;

  const AccessRequestsDoctorLoaded({
    required this.sendRequests,
    required this.acceptedRequests,
  });

  @override
  List<Object?> get props => [sendRequests, acceptedRequests];
}

class AccessRequestsDoctorError extends AccessRequestsDoctorState {
  final String message;

  const AccessRequestsDoctorError(this.message);

  @override
  List<Object?> get props => [message];
}
