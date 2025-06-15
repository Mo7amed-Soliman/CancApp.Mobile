import 'package:equatable/equatable.dart';

abstract class AccessRecordTypeDoctorState extends Equatable {
  const AccessRecordTypeDoctorState();

  @override
  List<Object?> get props => [];
}

class AccessRecordTypeDoctorInitial extends AccessRecordTypeDoctorState {
  const AccessRecordTypeDoctorInitial();
}

class AccessRecordTypeDoctorLoading extends AccessRecordTypeDoctorState {
  const AccessRecordTypeDoctorLoading();
}

class AccessRecordTypeDoctorSuccess extends AccessRecordTypeDoctorState {
  final List<dynamic> records;

  const AccessRecordTypeDoctorSuccess(this.records);

  @override
  List<Object?> get props => [records];
}

class AccessRecordTypeDoctorError extends AccessRecordTypeDoctorState {
  final String errorMessage;

  const AccessRecordTypeDoctorError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
