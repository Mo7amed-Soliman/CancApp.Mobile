import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/secure_cache_helper.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/shared_feature/login/data/models/login_model.dart';
import 'package:canc_app/core/models/user_model.dart';
import 'package:canc_app/core/shared_feature/login/data/repositories/login_repository.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;

  LoginCubit({required LoginRepository loginRepository})
      : _loginRepository = loginRepository,
        super(LoginInitial());

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
    final result = await _loginRepository.login(
      loginModel: LoginModel(
        email: emailInput!,
        password: passwordInput!,
      ),
    );
    result.fold(
      (failure) => emit(LoginFailed(errMessage: failure.errorMessage)),
      (userModel) async {
        await _loginRepository.saveFcmToken(
          token: await getIt<SecureCacheHelper>()
                  .getData(key: CacheKeys.fcmToken) ??
              '',
        );
        emit(LoginSuccess(userModel: userModel));
      },
    );
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
