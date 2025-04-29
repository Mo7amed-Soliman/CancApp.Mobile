import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color backgroundColor;
  final double width;
  final bool isLoading;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final double? loaderSize;
  final Color loaderColor;

  const AppButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = AppColors.primaryColor,
    this.width = double.infinity,
    this.isLoading = false,
    this.borderRadius = 10,
    this.padding,
    this.textStyle,
    this.loaderSize = 26,
    this.loaderColor = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextStyle =
        textStyle ?? AppTextStyle.font20MediumWhite(context);

    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: _buildButtonStyle(context),
        onPressed: isLoading ? null : onPressed,
        child: _buildButtonContent(context, effectiveTextStyle),
      ),
    );
  }

  ButtonStyle _buildButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      padding: padding ?? EdgeInsets.symmetric(vertical: context.setHeight(15)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.setMinSize(borderRadius)),
      ),
      minimumSize: const Size.fromHeight(48),
    );
  }

  Widget _buildButtonContent(BuildContext context, TextStyle textStyle) {
    if (isLoading) {
      return SizedBox.square(
        dimension: loaderSize,
        child: CircularProgressIndicator(
          color: loaderColor,
          strokeWidth: 3,
        ),
      );
    }

    return Text(
      text,
      style: textStyle,
      semanticsLabel: text,
    );
  }
}
