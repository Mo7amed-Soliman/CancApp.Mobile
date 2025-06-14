import 'package:equatable/equatable.dart';

abstract class AccessRequestsDoctorState extends Equatable {
  const AccessRequestsDoctorState();

  @override
  List<Object?> get props => [];
}

class AccessRequestsDoctorInitial extends AccessRequestsDoctorState {}

class AccessRequestsDoctorLoading extends AccessRequestsDoctorState {}

class AccessRequestsDoctorLoaded extends AccessRequestsDoctorState {
  const AccessRequestsDoctorLoaded();
}

class AccessRequestsDoctorError extends AccessRequestsDoctorState {
  final String message;

  const AccessRequestsDoctorError(this.message);

  @override
  List<Object?> get props => [message];
}
