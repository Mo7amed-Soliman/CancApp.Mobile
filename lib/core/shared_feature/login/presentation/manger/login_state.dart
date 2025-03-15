part of 'login_cubit.dart';

sealed class LoginState {}

// login with email and password
final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFailed extends LoginState {
  final String errMessage;

  LoginFailed({required this.errMessage});
}

// Form validation state
final class FormValidationState extends LoginState {}

// Password visibility state
final class PasswordVisibilityUpdated extends LoginState {}
