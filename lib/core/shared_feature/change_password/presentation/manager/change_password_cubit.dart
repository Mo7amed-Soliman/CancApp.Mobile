import 'package:canc_app/core/helpers/extension/regex_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final LocalAuthentication _localAuth;

  ChangePasswordCubit({LocalAuthentication? localAuth})
      : _localAuth = localAuth ?? LocalAuthentication(),
        super(ChangePasswordInitial());

  final formKey = GlobalKey<FormState>();
  AutovalidateMode validationMode = AutovalidateMode.disabled;
  String? oldPasswordInput;
  String? newPasswordInput;
  String? confirmNewPasswordInput;
  bool isOldPasswordObscured = true;
  bool isNewPasswordObscured = true;
  bool isConfirmPasswordObscured = true;

  Future<bool> _authenticate() async {
    final canAuth = await _localAuth.canCheckBiometrics ||
        await _localAuth.isDeviceSupported();
    if (!canAuth) return false;

    try {
      return await _localAuth.authenticate(
        localizedReason: 'Authenticate to change your password',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ChangePasswordLoading());

    try {
      final authenticated = await _authenticate();
      if (!authenticated) {
        emit(const ChangePasswordError('Authentication failed'));
        return;
      }

      if (newPassword != confirmPassword) {
        emit(const ChangePasswordError('Passwords do not match'));
        return;
      }

      // TODO: Add your password change logic here
      // For example, call an API or update local storage

      emit(const ChangePasswordSuccess('Password changed successfully'));
    } catch (e) {
      emit(ChangePasswordError(e.toString()));
    }
  }

  Future<void> performChangePassword() async {
    if (!_validateForm()) {
      emit(const FormValidationState(isValid: false));
      return;
    }

    formKey.currentState!.save();
    await changePassword(
      oldPassword: oldPasswordInput!,
      newPassword: newPasswordInput!,
      confirmPassword: confirmNewPasswordInput!,
    );
  }

  bool _validateForm() {
    validationMode = AutovalidateMode.always;
    final isValid = formKey.currentState?.validate() ?? false;
    emit(FormValidationState(isValid: isValid));
    return isValid;
  }

  void toggleOldPasswordVisibility() {
    isOldPasswordObscured = !isOldPasswordObscured;
    emit(PasswordVisibilityUpdated(
      isOldPasswordVisible: isOldPasswordObscured,
      isNewPasswordVisible: isNewPasswordObscured,
      isConfirmPasswordVisible: isConfirmPasswordObscured,
    ));
  }

  Widget buildOldPasswordVisibilityIcon() {
    return IconButton(
      icon: Icon(
        isOldPasswordObscured ? Icons.visibility : Icons.visibility_off,
        color: AppColors.primaryColor,
      ),
      onPressed: toggleOldPasswordVisibility,
    );
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordObscured = !isNewPasswordObscured;
    emit(PasswordVisibilityUpdated(
      isOldPasswordVisible: isOldPasswordObscured,
      isNewPasswordVisible: isNewPasswordObscured,
      isConfirmPasswordVisible: isConfirmPasswordObscured,
    ));
  }

  Widget buildNewPasswordVisibilityIcon() {
    return IconButton(
      icon: Icon(
        isNewPasswordObscured ? Icons.visibility : Icons.visibility_off,
        color: AppColors.primaryColor,
      ),
      onPressed: toggleNewPasswordVisibility,
    );
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured = !isConfirmPasswordObscured;
    emit(PasswordVisibilityUpdated(
      isOldPasswordVisible: isOldPasswordObscured,
      isNewPasswordVisible: isNewPasswordObscured,
      isConfirmPasswordVisible: isConfirmPasswordObscured,
    ));
  }

  Widget buildConfirmPasswordVisibilityIcon() {
    return IconButton(
      icon: Icon(
        isConfirmPasswordObscured ? Icons.visibility : Icons.visibility_off,
        color: AppColors.primaryColor,
      ),
      onPressed: toggleConfirmPasswordVisibility,
    );
  }

  // Password validation
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  void updateNewPasswordValidation(String newPassword) {
    newPasswordInput = newPassword;

    hasLowercase = newPassword.hasLowerCase;
    hasUppercase = newPassword.hasUpperCase;
    hasSpecialCharacters = newPassword.hasSpecialCharacter;
    hasNumber = newPassword.hasDigit;
    hasMinLength = newPassword.hasMinLength;

    emit(
      PasswordValidationUpdated(
        hasLowercase: hasLowercase,
        hasUppercase: hasUppercase,
        hasSpecialCharacters: hasSpecialCharacters,
        hasNumber: hasNumber,
        hasMinLength: hasMinLength,
      ),
    );
  }

  bool passwordsMatch() {
    if (newPasswordInput == null || confirmNewPasswordInput == null) {
      return false;
    }
    final match = newPasswordInput == confirmNewPasswordInput;
    emit(PasswordMatchUpdated(match: match));
    return match;
  }

  void updateConfirmPassword(String confirmPassword) {
    confirmNewPasswordInput = confirmPassword;
    emit(PasswordMatchUpdated(match: passwordsMatch()));
  }
}
