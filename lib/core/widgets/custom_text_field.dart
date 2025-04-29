import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.prefixIcon,
    this.hintText,
    this.textColor,
    this.fillColor,
    this.hintColor,
    this.filled,
    this.autofocus = false,
    this.suffixIcon,
    this.focusNode,
  });
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final String? hintText;
  final Color? textColor;
  final Color? hintColor;
  final Color? fillColor;
  final bool? filled;
  final bool autofocus;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      autofocus: autofocus,
      minLines: 1,
      maxLines: 5,
      style: AppTextStyle.font16RegularDarkGray(context).copyWith(
        color: textColor ?? AppColors.offWhite,
      ),
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: filled,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: AppTextStyle.font16RegularDarkGray(context)
            .copyWith(color: hintColor ?? AppColors.offWhite),
        border: _buildSearchBorder(),
        enabledBorder: _buildSearchBorder(),
        focusedBorder: _buildSearchBorder(isFocused: true),
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.setMinSize(20),
          vertical: context.setMinSize(6),
        ),
      ),
    );
  }

  OutlineInputBorder _buildSearchBorder({bool isFocused = false}) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        color: fillColor ??
            AppColors.offWhite.withValues(
              alpha: isFocused ? 1.0 : 0.3,
            ),
      ),
    );
  }
}
