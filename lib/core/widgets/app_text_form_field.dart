import 'package:canc_app/core/helpers/extension/regex_extension.dart';
import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/theming/font_weight_helper.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.keyboardType,
    this.autofillHints,
    this.autofocus = false,
    this.textInputAction = TextInputAction.next,
    this.fillColor,
    this.filled,
    this.labelStyle,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String?>? validator;
  final bool obscureText;
  final ValueChanged<String?>? onSaved;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  final bool autofocus;
  final TextInputAction textInputAction;
  final Color? fillColor;
  final bool? filled;
  final TextStyle? labelStyle;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ?? AppTextStyle.font16RegularDarkGray(context),
        ),
        const VerticalSpacer(6),
        TextFormField(
          textInputAction: textInputAction,
          controller: controller,
          autofillHints: autofillHints,
          autofocus: autofocus,
          obscureText: obscureText,
          onSaved: onSaved,
          onChanged: onChanged,
          enabled: enabled,
          validator: _getValidator(label),
          keyboardType: keyboardType ?? _getKeyboardType(label),
          cursorColor: AppColors.primaryColor,
          style: AppTextStyle.font14RegularDarkGray(context),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            fillColor: fillColor ?? AppColors.paleTealTransparent,
            filled: filled ?? true,
            border: _borderStyle(),
            enabledBorder: _borderStyle(color: AppColors.paleTealTransparent),
            focusedBorder: _borderStyle(),
            errorBorder: _borderStyle(color: AppColors.red),
            disabledBorder: _borderStyle(color: AppColors.paleTealTransparent),
            errorStyle: TextStyle(
              color: AppColors.red,
              fontSize: context.setSp(13),
              fontWeight: FontWeightHelper.regular,
              overflow: TextOverflow.visible,
            ),
            focusedErrorBorder: _borderStyle(),
            hintText: hintText,
            hintStyle: AppTextStyle.font14RegularDarkGray(context),
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.setWidth(16),
              vertical: context.setHeight(20),
            ),
          ),
        ),
      ],
    );
  }

  /// Returns the border style
  OutlineInputBorder _borderStyle({
    Color color = AppColors.primaryColor,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: color,
        width: 2,
      ),
    );
  }

  /// Returns the keyboard type based on the label
  TextInputType _getKeyboardType(String label) {
    final lowerLabel = label.toLowerCase();

    if (lowerLabel.contains('email')) {
      return TextInputType.emailAddress;
    } else if (lowerLabel.contains('password')) {
      return TextInputType.visiblePassword;
    } else if (lowerLabel.contains('phone')) {
      return TextInputType.phone;
    } else if (lowerLabel.contains('name')) {
      return TextInputType.name;
    }
    return TextInputType.text;
  }

  String? Function(String?)? _getValidator(String label) {
    /// If validator is provided, return it
    if (validator != null) return validator;

    /// Arabic
    if (isArabic()) {
      return (String? value) {
        if (value == null || value.isEmpty) {
          return '$label مطلوب';
        }
        // Email validation
        if (label.contains('البريد الإلكتروني') && !value.isValidEmail) {
          return 'يرجى إدخال عنوان بريد إلكتروني صحيح';
        }

        return null;
      };
    }

    /// English
    return (String? value) {
      if (value == null || value.isEmpty) {
        return '$label is required';
      }

      final lowerLabel = label.toLowerCase();

      // Email validation
      if (lowerLabel.contains('email') && !value.isValidEmail) {
        return 'Enter a valid email address';
      }
      return null;
    };
  }
}
