sealed class OtpState {}

// otp state
final class InitialState extends OtpState {}

final class LoadingVerifyCodeState extends OtpState {}

class SuccessVerifyCodeState extends OtpState {}

class FailedVerifyCodeState extends OtpState {
  final String errorMessage;

  FailedVerifyCodeState({required this.errorMessage});
}

class OtpInputState extends OtpState {
  final String codeInput;

  OtpInputState({required this.codeInput});
}
