import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/models/otp_model.dart';
import 'package:canc_app/core/shared_feature/otp/presentation/view/widgets/otp_header.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'custom_bloc_consumer.dart';

class OtpViewBody extends StatelessWidget {
  const OtpViewBody({
    super.key,
    required this.otpModel,
  });
  final OtpModel otpModel;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.screenWidth * 0.06,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpacer(32),
          OTPHeader(otpModel: otpModel),
          const VerticalSpacer(32),
          CustomBlocConsumer(
<<<<<<< HEAD
            otpModel: otpModel,
=======
            isForgetPassword: otpModel.isForgotPassword,
>>>>>>> 6dc5276 (- forget password done)
          ),
          const VerticalSpacer(8),
        ],
      ),
    );
  }
}
