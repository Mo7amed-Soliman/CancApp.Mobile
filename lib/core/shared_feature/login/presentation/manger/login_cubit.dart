import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  // Form management
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode validationMode = AutovalidateMode.disabled;
  String? emailInput;
  String? passwordInput;

  Future<void> performLogin() async {
    if (!_validateForm()) return;

    formKey.currentState!.save();
    await _authenticateUser();
  }

  bool _validateForm() {
    if (formKey.currentState!.validate()) return true;

    validationMode = AutovalidateMode.always;
    emit(FormValidationState());
    return false;
  }

  Future<void> _authenticateUser() async {
    emit(LoginLoading());
    // Implementation for authentication
    // emit(LoginLoading());
    // ... authentication logic
  }

  // Password visibility
  bool isPasswordObscured = true;
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
}
