import 'package:canc_app/core/shared_feature/forgot_password/data/repositories/forget_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit({
    required ForgetPasswordRepository forgetPasswordRepository,
  })  : _forgetPasswordRepository = forgetPasswordRepository,
        super(InitialState());

  final ForgetPasswordRepository _forgetPasswordRepository;

  // Form management
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode validationMode = AutovalidateMode.disabled;
  String? emailInput;

  void sendCode() async {
    if (!_validateForm()) return;

    formKey.currentState!.save();
    _performForgotPasswordSendCode();
  }

  bool _validateForm() {
    if (formKey.currentState!.validate()) return true;

    validationMode = AutovalidateMode.always;
    emit(FormValidationState());
    return false;
  }

  void _performForgotPasswordSendCode() async {
    /// Perform forgot password send code
    emit(LoadingSendCodeState());
    final result = await _forgetPasswordRepository.forgetPassword(
      email: emailInput!,
    );
    result.fold(
      (failure) => emit(
        FailedSendCodeState(errorMessage: failure.errorMessage),
      ),
      (success) => emit(SuccessSensCodeState()),
    );
  }
}
