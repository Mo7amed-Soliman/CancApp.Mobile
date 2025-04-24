part of 'reset_password_cubit.dart';

sealed class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

// Initial state
final class ResetPasswordInitial extends ResetPasswordState {}

// Loading states
final class ResetPasswordLoading extends ResetPasswordState {}

// Success states
final class ResetPasswordSuccess extends ResetPasswordState {}

// Error states
final class ResetPasswordError extends ResetPasswordState {
  final String message;

  const ResetPasswordError(this.message);

  @override
  List<Object> get props => [message];
}

// Form states
final class FormValidationState extends ResetPasswordState {
  final bool isValid;

  const FormValidationState({required this.isValid});

  @override
  List<Object> get props => [isValid];
}

// Password validation states
final class PasswordValidationUpdated extends ResetPasswordState {
  final bool hasLowercase;
  final bool hasUppercase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;

  const PasswordValidationUpdated({
    required this.hasLowercase,
    required this.hasUppercase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  List<Object> get props => [
        hasLowercase,
        hasUppercase,
        hasSpecialCharacters,
        hasNumber,
        hasMinLength,
      ];
}

// Password visibility states
final class PasswordVisibilityUpdated extends ResetPasswordState {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  const PasswordVisibilityUpdated({
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
  });

  @override
  List<Object> get props => [isPasswordVisible, isConfirmPasswordVisible];
}

// Password match states
final class PasswordMatchUpdated extends ResetPasswordState {
  final bool match;

  const PasswordMatchUpdated({required this.match});

  @override
  List<Object> get props => [match];
}
