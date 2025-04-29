part of 'forgot_password_cubit.dart';

sealed class ForgotPasswordState {}

// forgot password state
final class InitialState extends ForgotPasswordState {}

final class LoadingSendCodeState extends ForgotPasswordState {}

final class SuccessSensCodeState extends ForgotPasswordState {}

final class FailedSendCodeState extends ForgotPasswordState {
  final String errorMessage;

  FailedSendCodeState({
    required this.errorMessage,
  });
}

// Form validation state
final class FormValidationState extends ForgotPasswordState {}
