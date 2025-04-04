import 'dart:developer';

import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  // Form management
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode validationMode = AutovalidateMode.disabled;

  String? fullNameInput;
  String? addressInput;
  String? emailInput;
  String? passwordInput;
  String? confirmPasswordInput;

  Future<void> performSignUp() async {
    if (!_validateForm()) return;

    formKey.currentState!.save();
    await _authenticateUser();
  }

  bool _validateForm() {
    validationMode = AutovalidateMode.always;
    if (formKey.currentState!.validate()) return true;

    emit(FormValidationState());
    return false;
  }

  Future<void> _authenticateUser() async {
    emit(SignUpLoading());
    // Implementation for authentication
    // emit(LoginLoading());
    // ... authentication logic
  }

  // Password visibility
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;
  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    emit(PasswordVisibilityUpdated());
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
    emit(PasswordVisibilityUpdated());
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

  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  void updatePasswordValidation(String password) {
    passwordInput = password;
    hasLowercase = password.contains(RegExp(r'[a-z]'));
    hasUppercase = password.contains(RegExp(r'[A-Z]'));
    hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    hasNumber = password.contains(RegExp(r'[0-9]'));
    hasMinLength = password.length >= 8;

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
    if (passwordInput == null || confirmPasswordInput == null) {
      log('Passwords are null');
      return false;
    }
    return passwordInput == confirmPasswordInput;
  }

  void updateConfirmPassword(String confirmPassword) {
    confirmPasswordInput = confirmPassword;
    emit(PasswordMatchUpdated(match: passwordsMatch()));
  }
}
