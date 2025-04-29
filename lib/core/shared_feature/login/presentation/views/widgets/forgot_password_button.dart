import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ForgotPasswordButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isArabic() ? Alignment.centerLeft : Alignment.centerRight,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          S.of(context).forgotPasswordIntr,
          style: AppTextStyle.font14RegularDarkGray(context).copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
