import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
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
        padding: EdgeInsets.all(context.setMinSize(17)),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.paleTealTransparent,
          borderRadius: BorderRadius.circular(context.setMinSize(10)),
        ),
        child: Text(
          language,
          style: AppTextStyle.font20MediumWhite(context).copyWith(
            color: isSelected ? AppColors.offWhite : AppColors.darkGray,
          ),
        ),
      ),
    );
  }
}
