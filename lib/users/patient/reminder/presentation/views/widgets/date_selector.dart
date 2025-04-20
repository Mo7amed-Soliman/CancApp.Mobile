import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const DateSelector({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: context.setHeight(18),
          horizontal: context.setWidth(16),
        ),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(context.setWidth(16)),
          border: Border.all(
            color: AppColors.paleTealTransparent,
            width: 2,
          ),
        ),
        child: Text(
          text,
          style: AppTextStyle.font14RegularDarkGray(context),
        ),
      ),
    );
  }
}
