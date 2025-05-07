import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object?> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  final String message;

  const ChangePasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ChangePasswordError extends ChangePasswordState {
  final String message;

  const ChangePasswordError(this.message);

  @override
  List<Object?> get props => [message];
}

final class FormValidationState extends ChangePasswordState {
  final bool isValid;

  const FormValidationState({required this.isValid});

  @override
  List<Object> get props => [isValid];
}

// Password validation states
final class PasswordValidationUpdated extends ChangePasswordState {
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
final class PasswordVisibilityUpdated extends ChangePasswordState {
  final bool isOldPasswordVisible;
  final bool isNewPasswordVisible;
  final bool isConfirmPasswordVisible;

  const PasswordVisibilityUpdated({
    required this.isOldPasswordVisible,
    required this.isNewPasswordVisible,
    required this.isConfirmPasswordVisible,
  });

  @override
  List<Object> get props => [
        isOldPasswordVisible,
        isNewPasswordVisible,
        isConfirmPasswordVisible,
      ];
}

// Password match states
final class PasswordMatchUpdated extends ChangePasswordState {
  final bool match;

  const PasswordMatchUpdated({required this.match});

  @override
  List<Object> get props => [match];
}
