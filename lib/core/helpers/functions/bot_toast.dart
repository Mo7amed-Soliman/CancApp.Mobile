import 'package:bot_toast/bot_toast.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

void botTextToast(String text, {Color? color}) {
  BotToast.showCustomText(
    align: Alignment.topCenter,
    duration: const Duration(seconds: 5),
    toastBuilder: (context) => Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color ?? AppColors.red,
          fontSize: 16,
          fontFamily: AppTextStyle.fontFamily,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
