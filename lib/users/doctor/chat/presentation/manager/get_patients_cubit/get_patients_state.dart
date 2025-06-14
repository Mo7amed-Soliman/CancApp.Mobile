import 'package:canc_app/core/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class GetPatientsState extends Equatable {
  const GetPatientsState();

  @override
  List<Object?> get props => [];
}

class GetPatientsInitial extends GetPatientsState {
  const GetPatientsInitial();
}

class GetPatientsLoading extends GetPatientsState {
  const GetPatientsLoading();
}

class GetPatientsSuccess extends GetPatientsState {
  final List<UserModel> patients;

  const GetPatientsSuccess(this.patients);

  @override
  List<Object?> get props => [patients];
}

class GetPatientsError extends GetPatientsState {
  final String errorMessage;

  const GetPatientsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
