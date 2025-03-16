import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/core/shared_feature/forgot_password/presentation/views/widgets/otp_input_section.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';

import 'widgets/otp_header.dart';
import 'widgets/resend_code_button.dart';
import 'widgets/verify_button.dart';

class OTPView extends StatelessWidget {
  const OTPView({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      foregroundColor: AppColors.darkGray,
      backgroundColor: AppColors.offWhite,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpacer(32),
          OTPHeader(email: email),
          const VerticalSpacer(32),
          const Align(
            alignment: Alignment.center,
            child: OTPInput(),
          ),
          const VerticalSpacer(32),
          VerifyButton(
            onPressed: () {
              // Add verification logic here
            },
          ),
          ResendCodeButton(
            onPressed: () {
              // Add resend code logic here
            },
          ),
          const VerticalSpacer(8),
        ],
      ),
    );
  }
}
