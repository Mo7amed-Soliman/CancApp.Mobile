import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class PasswordValidations extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const PasswordValidations({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Column(
        children: [
          buildValidationRow(
            S.of(context).lowercaseValidation,
            hasLowerCase,
            context,
          ),
          const SizedBox(height: 2),
          buildValidationRow(
            S.of(context).uppercaseValidation,
            hasUpperCase,
            context,
          ),
          const SizedBox(height: 2),
          buildValidationRow(
            S.of(context).specialCharacterValidation,
            hasSpecialCharacters,
            context,
          ),
          const SizedBox(height: 2),
          buildValidationRow(
            S.of(context).numberValidation,
            hasNumber,
            context,
          ),
          const SizedBox(height: 2),
          buildValidationRow(
            S.of(context).minLengthValidation,
            hasMinLength,
            context,
          ),
        ],
      ),
    );
  }

  Widget buildValidationRow(
      String text, bool hasValidated, BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 2.5,
          backgroundColor:
              hasValidated ? AppColors.mediumGray : AppColors.primaryColor,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: AppTextStyle.font14RegularDarkGray(context).copyWith(
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: AppColors.primaryColor,
            decorationThickness: 2,
            color: hasValidated ? AppColors.mediumGray : AppColors.darkGray,
          ),
        )
      ],
    );
  }
}
