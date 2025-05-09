import 'package:canc_app/core/helpers/extension/regex_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/forget_password_repository.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(
      {required ForgetPasswordRepository forgetPasswordRepository})
      : _forgetPasswordRepository = forgetPasswordRepository,
        super(ResetPasswordInitial());

  final ForgetPasswordRepository _forgetPasswordRepository;

  // Form management
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode validationMode = AutovalidateMode.disabled;

  String? newPasswordInput;
  String? confirmNewPasswordInput;

  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    emit(ResetPasswordLoading());
    try {
      final result = await _forgetPasswordRepository.resetPassword(
        email: email,
        newPassword: newPassword,
      );

      result.fold(
        (failure) => emit(ResetPasswordError(failure.errorMessage)),
        (success) => emit(ResetPasswordSuccess()),
      );
    } catch (error) {
      emit(ResetPasswordError(error.toString()));
    }
  }

  Future<void> performResetPassword(
    String email,
  ) async {
    if (!_validateForm()) {
      emit(const FormValidationState(isValid: false));
      return;
    }

    formKey.currentState!.save();
    await resetPassword(
      email: email,
      newPassword: newPasswordInput!,
    );
  }

  bool _validateForm() {
    validationMode = AutovalidateMode.always;
    final isValid = formKey.currentState?.validate() ?? false;
    emit(FormValidationState(isValid: isValid));
    return isValid;
  }

  // Password visibility
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    emit(PasswordVisibilityUpdated(
      isPasswordVisible: !isPasswordObscured,
      isConfirmPasswordVisible: !isConfirmPasswordObscured,
    ));
  }

  Widget buildVisibilityToggleIcon() {
    return IconButton(
      icon: Icon(
        isPasswordObscured ? Icons.visibility : Icons.visibility_off,
        color: AppColors.primaryColor,
      ),
      onPressed: togglePasswordVisibility,
    );
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured = !isConfirmPasswordObscured;
    emit(PasswordVisibilityUpdated(
      isPasswordVisible: !isPasswordObscured,
      isConfirmPasswordVisible: !isConfirmPasswordObscured,
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
