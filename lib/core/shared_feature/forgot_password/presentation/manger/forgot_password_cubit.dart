import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(InitialState());

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

  void _performForgotPasswordSendCode() {
    /// Perform forgot password send code
    emit(SuccessSensCodeState());
  }
}
