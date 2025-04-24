import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/extension/regex_extension.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/shared_feature/sign_up/data/models/sign_up_model.dart';
import 'package:canc_app/core/shared_feature/sign_up/data/repositories/sign_up_repository.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required SignUpRepository signUpRepository})
      : _signUpRepository = signUpRepository,
        super(SignUpInitial());
  final SignUpRepository _signUpRepository;
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
    final signUpModel = SignUpModel(
      email: emailInput!,
      password: passwordInput!,
      name: fullNameInput!,
      address: addressInput!,
      userType: getIt<CacheHelper>().getData(key: CacheKeys.whoAreYou),
    );
    final result = await _signUpRepository.signUp(signUpModel: signUpModel);
    result.fold(
      (failure) => emit(SignUpFailed(failure.errorMessage)),
      (success) async {
        final result = await _signUpRepository.resendConfirmEmail(
          email: signUpModel.email,
        );
        result.fold(
          (failure) => emit(SignUpFailed(failure.errorMessage)),
          (success) => emit(SignUpSuccess()),
        );
      },
    );
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

    hasLowercase = password.hasLowerCase;
    hasUppercase = password.hasUpperCase;
    hasSpecialCharacters = password.hasSpecialCharacter;
    hasNumber = password.hasDigit;
    hasMinLength = password.hasMinLength;

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
      return false;
    }
    return passwordInput == confirmPasswordInput;
  }

  void updateConfirmPassword(String confirmPassword) {
    confirmPasswordInput = confirmPassword;
    emit(PasswordMatchUpdated(match: passwordsMatch()));
  }
}
