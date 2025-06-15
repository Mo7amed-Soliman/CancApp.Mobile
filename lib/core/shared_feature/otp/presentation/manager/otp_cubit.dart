import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/secure_cache_helper.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/models/otp_model.dart';
import 'package:canc_app/core/shared_feature/otp/data/repositories/otp_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final OtpRepository _otpRepository;
  final OtpModel otpModel;

  OtpCubit({
    required OtpRepository otpRepository,
    required this.otpModel,
  })  : _otpRepository = otpRepository,
        super(InitialState());

  // Form management

  String? codeInput;

  Future<void> verifyCode() async {
    emit(LoadingVerifyCodeState());

    final result = await _otpRepository.verifyCode(
      email: otpModel.email,
      code: codeInput!,
    );

    result.fold(
      (failure) {
        emit(FailedVerifyCodeState(errorMessage: failure.errorMessage));
      },
      (success) async {
        final result = await _otpRepository.saveFcmToken(
          token: await getIt<SecureCacheHelper>()
                  .getData(key: CacheKeys.fcmToken) ??
              '',
        );

        result.fold(
          (failure) =>
              emit(FailedVerifyCodeState(errorMessage: failure.errorMessage)),
          (success) => emit(SuccessVerifyCodeState()),
        );
      },
    );
  }

  Future<void> resendCode() async {
    emit(LoadingVerifyCodeState());

    final result = await _otpRepository.resendCode(
      email: otpModel.email,
    );

    result.fold(
      (failure) {
        emit(FailedVerifyCodeState(errorMessage: failure.errorMessage));
      },
      (success) => emit(InitialState()),
    );
  }

  Future<void> verifyCodeForgetPassword() async {
    emit(LoadingVerifyCodeState());

    final result = await _otpRepository.verifyCodeForgetPassword(
      email: otpModel.email,
      code: codeInput!,
    );

    result.fold(
      (failure) {
        emit(FailedVerifyCodeState(errorMessage: failure.errorMessage));
      },
      (success) => emit(SuccessVerifyCodeState()),
    );
  }

  bool completedCode = false;
  void onChanged(String value) {
    codeInput = value;
    completedCode = value.length == 4;
    emit(OtpInputState(codeInput: value));
  }
}
