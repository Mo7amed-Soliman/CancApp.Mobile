import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

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
      // TODO: Add reset password implementation when the endpoint is ready
      // await _forgetPasswordRemoteDataSource.resetPassword(
      //   email: email,
      //   newPassword: newPassword,
      //   confirmPassword: confirmPassword,
      //   code: code,
      // );

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      emit(ResetPasswordSuccess());
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

    if (!passwordsMatch()) {
      String errorMessage =
          isArabic() ? 'كلمة المرور غير متطابقة' : 'Passwords do not match';
      emit(ResetPasswordError(errorMessage));
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
    hasLowercase = newPassword.contains(RegExp(r'[a-z]'));
    hasUppercase = newPassword.contains(RegExp(r'[A-Z]'));
    hasSpecialCharacters =
        newPassword.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    hasNumber = newPassword.contains(RegExp(r'[0-9]'));
    hasMinLength = newPassword.length >= 8;

    final isValid = hasLowercase &&
        hasUppercase &&
        hasSpecialCharacters &&
        hasNumber &&
        hasMinLength;

    emit(
      PasswordValidationUpdated(
        hasLowercase: hasLowercase,
        hasUppercase: hasUppercase,
        hasSpecialCharacters: hasSpecialCharacters,
        hasNumber: hasNumber,
        hasMinLength: hasMinLength,
        isValid: isValid,
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
