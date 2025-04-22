import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/services/user_service.dart';
import 'package:canc_app/core/shared_feature/otp/data/repositories/otp_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final OtpRepository _otpRepository;
  final String email;

  OtpCubit({
    required OtpRepository otpRepository,
    required this.email,
  })  : _otpRepository = otpRepository,
        super(InitialState());

  // Form management

  String? codeInput;

  Future<void> verifyCode() async {
    emit(LoadingVerifyCodeState());

    final result = await _otpRepository.verifyCode(
      userId: getIt<UserService>().getUser()!.id,
      code: codeInput!,
    );

    result.fold(
      (failure) {
        emit(FailedVerifyCodeState(errorMessage: failure.errorMessage));
      },
      (success) => emit(SuccessVerifyCodeState()),
    );
  }

  Future<void> resendCode() async {
    emit(LoadingVerifyCodeState());

    final result = await _otpRepository.resendCode(
      email: email,
    );

    result.fold(
      (failure) {
        emit(FailedVerifyCodeState(errorMessage: failure.errorMessage));
      },
      (success) => emit(InitialState()),
    );
  }

  bool completedCode = false;
  void onChanged(String value) {
    codeInput = value;
    completedCode = value.length == 4;
    emit(OtpInputState(codeInput: value));
  }
}
