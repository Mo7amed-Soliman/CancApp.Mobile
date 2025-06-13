import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object?> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  const ChangePasswordSuccess();

  @override
  List<Object?> get props => [];
}

class ChangePasswordError extends ChangePasswordState {
  final String message;
  final bool isAuthError;

  const ChangePasswordError(this.message, {this.isAuthError = false});

  @override
  List<Object?> get props => [message, isAuthError];
}

class AuthenticationRequired extends ChangePasswordState {
  final String message;
  final bool isBiometricAvailable;
  final bool isDeviceLockAvailable;

  const AuthenticationRequired({
    required this.message,
    this.isBiometricAvailable = false,
    this.isDeviceLockAvailable = false,
  });

  @override
  List<Object?> get props =>
      [message, isBiometricAvailable, isDeviceLockAvailable];
}

class AuthenticationError extends ChangePasswordState {
  final String message;
  final bool isBiometricError;
  final bool isDeviceLockError;

  const AuthenticationError({
    required this.message,
    this.isBiometricError = false,
    this.isDeviceLockError = false,
  });

  @override
  List<Object?> get props => [message, isBiometricError, isDeviceLockError];
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
