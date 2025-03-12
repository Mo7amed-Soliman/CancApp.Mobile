import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class LanguageOptionWidget extends StatelessWidget {
  final String language;
  final bool isSelected;
  final Alignment alignment;
  final VoidCallback onTap;

  const LanguageOptionWidget({
    super.key,
    required this.language,
    required this.isSelected,
    required this.alignment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        alignment: alignment,
        width: double.infinity,
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : const Color(0xFFE3FAF7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          language,
          style: AppTextStyle.font20MediumDarkGray(context).copyWith(
            color: isSelected ? AppColors.offWhite : AppColors.darkGray,
          ),
        ),
      ),
    );
  }
}
