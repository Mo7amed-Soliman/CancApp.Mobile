import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class AuthPromptButton extends StatelessWidget {
  final String promptText;
  final String actionText;
  final VoidCallback onPressed;

  const AuthPromptButton({
    super.key,
    required this.promptText,
    required this.actionText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: RichText(
        text: TextSpan(
          text: '$promptText ',
          style: AppTextStyle.font14RegularDarkGray(context),
          children: [
            TextSpan(
              text: actionText,
              style: AppTextStyle.font14RegularDarkGray(context).copyWith(
                color: AppColors.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
