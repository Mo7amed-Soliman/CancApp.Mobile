import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class OTPHeader extends StatelessWidget {
  final String email;

  const OTPHeader({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).verificationCode,
          style: AppTextStyle.font24SemiBoldDarkGray(context),
        ),
        const VerticalSpacer(8),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${S.of(context).enterVerificationCode} ',
                style: AppTextStyle.font16MediumDarkGray(context),
              ),
              TextSpan(
                text: email,
                style: AppTextStyle.font14RegularDarkGray(context).copyWith(
                  color: AppColors.grayish,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
