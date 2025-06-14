import 'package:canc_app/core/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class GetAvailableUsersState extends Equatable {
  const GetAvailableUsersState();

  @override
  List<Object?> get props => [];
}

class GetAvailableUsersInitial extends GetAvailableUsersState {
  const GetAvailableUsersInitial();
}

class GetAvailableUsersLoading extends GetAvailableUsersState {
  const GetAvailableUsersLoading();
}

class GetAvailableUsersSuccess extends GetAvailableUsersState {
  final List<UserModel> users;

  const GetAvailableUsersSuccess(this.users);

  @override
  List<Object?> get props => [users];
}

class GetAvailableUsersError extends GetAvailableUsersState {
  final String errorMessage;

  const GetAvailableUsersError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
