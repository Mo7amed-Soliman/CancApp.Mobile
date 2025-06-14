import 'package:canc_app/core/helpers/extension/regex_extension.dart';
import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import '../../data/repositories/change_password_repository_impl.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final LocalAuthentication _localAuth;
  final ChangePasswordRepository _changePasswordRepository;

  ChangePasswordCubit({
    LocalAuthentication? localAuth,
    required ChangePasswordRepository changePasswordRepository,
  })  : _localAuth = localAuth ?? LocalAuthentication(),
        _changePasswordRepository = changePasswordRepository,
        super(ChangePasswordInitial());

  final formKey = GlobalKey<FormState>();
  AutovalidateMode validationMode = AutovalidateMode.disabled;
  String? oldPasswordInput;
  String? newPasswordInput;
  String? confirmNewPasswordInput;
  bool isOldPasswordObscured = true;
  bool isNewPasswordObscured = true;
  bool isConfirmPasswordObscured = true;

  Future<bool> _checkDeviceSupport() async {
    try {
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      if (!isDeviceSupported) {
        emit(ChangePasswordError(
          isArabic()
              ? 'جهازك لا يدعم المصادقة'
              : 'Your device does not support authentication',
        ));
        return false;
      }
      return true;
    } catch (e) {
      emit(ChangePasswordError(
        isArabic()
            ? 'حدث خطأ أثناء التحقق من دعم الجهاز'
            : 'Error checking device support',
      ));
      return false;
    }
  }

  Future<bool> _checkBiometricAvailability() async {
    try {
      final canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        return false;
      }

      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      return availableBiometrics.isNotEmpty;
    } catch (e) {
      emit(ChangePasswordError(
        isArabic()
            ? 'حدث خطأ أثناء التحقق من المصادقة البيومترية'
            : 'Error checking biometric availability',
      ));
      return false;
    }
  }

  Future<bool> _authenticate() async {
    try {
      // First check if device supports authentication
      if (!await _checkDeviceSupport()) {
        return false;
      }

      // Check if biometrics are available
      final hasBiometrics = await _checkBiometricAvailability();

      // Attempt authentication
      final authenticated = await _localAuth.authenticate(
        localizedReason: isArabic()
            ? 'تحقق من هويتك لتغيير كلمة المرور'
            : 'Authenticate to change your password',
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: hasBiometrics, // Only use biometrics if available
        ),
      );

      if (!authenticated) {
        emit(ChangePasswordError(
          isArabic() ? 'فشل التحقق من هويتك' : 'Authentication failed',
        ));
      }

      return authenticated;
    } catch (e) {
      emit(ChangePasswordError(
        isArabic()
            ? 'حدث خطأ أثناء التحقق من هويتك'
            : 'Error during authentication',
      ));
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
      // Validate passwords match
      if (newPassword != confirmPassword) {
        emit(ChangePasswordError(
          isArabic() ? 'كلمات المرور غير متطابقة' : 'Passwords do not match',
        ));
        return;
      }

      // Attempt authentication
      final authenticated = await _authenticate();
      if (!authenticated) {
        return;
      }

      // Proceed with password change
      final result = await _changePasswordRepository.changePassword(
        oldPassword,
        newPassword,
      );

      result.fold(
        (failure) => emit(ChangePasswordError(failure.errorMessage)),
        (success) => emit(const ChangePasswordSuccess()),
      );
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
