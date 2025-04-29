part of 'sign_up_cubit.dart';

sealed class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailed extends SignUpState {
  final String errMessage;
  SignUpFailed(this.errMessage);
}

// Form validation state
final class FormValidationState extends SignUpState {}

// Password visibility state
final class PasswordVisibilityUpdated extends SignUpState {}

//   Password Validation State
class PasswordValidationUpdated extends SignUpState {
  final bool hasLowercase;
  final bool hasUppercase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;

  PasswordValidationUpdated({
    required this.hasLowercase,
    required this.hasUppercase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });
}

//   Password Match State
class PasswordMatchUpdated extends SignUpState {
  final bool match;
  PasswordMatchUpdated({required this.match});
}
