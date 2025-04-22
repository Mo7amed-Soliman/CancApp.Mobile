import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPInput extends StatelessWidget {
  const OTPInput({
    super.key,
    required this.onCompleted,
    required this.onChanged,
  });

  final Function(String) onCompleted;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: context.setMinSize(62),
      height: context.setMinSize(63),
      textStyle: AppTextStyle.font24SemiBoldDarkGray(context)
          .copyWith(color: AppColors.primaryColor),
      decoration: BoxDecoration(
        color: AppColors.offWhite, // Background color
        border: Border.all(
          color: AppColors.mediumGray,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
    );

    // Define the focused pin theme
    final focusedPinTheme = defaultPinTheme.copyWith(
      width: context.setMinSize(64),
      height: context.setMinSize(65),
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(
          color: AppColors.primaryColor,
          width: 2,
        ), // Focused border color
      ), // Keep the same background color
    );

    // Define the submitted pin theme
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: AppColors.lightTealBackground
            .withValues(alpha: 0.20), // Filled background when submitted
        border: Border.all(
          color: AppColors.mediumGray,
          width: 2,
        ), // Submitted border color
      ),
    );

    return Pinput(
      length: 4,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      separatorBuilder: (index) => const HorizontalSpacer(24),
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      pinAnimationType: PinAnimationType.fade,
      showCursor: false,
      autofocus: true,
      onCompleted: onCompleted, // Handle OTP completion
      onChanged: onChanged,
    );
  }
}
