import 'package:bot_toast/bot_toast.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

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

void showSuccessToast(String message) {
  BotToast.showCustomText(
    toastBuilder: (_) => Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.offWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0XFF03C5B9),
                    Color.fromARGB(255, 12, 128, 120),
                  ],
                ),
              ),
              child: const Icon(
                IconlyLight.tick_square,
                color: Colors.white,
                size: 60,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                fontFamily: AppTextStyle.fontFamily,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    ),
    duration: const Duration(seconds: 2),
    align: Alignment.center,
    onlyOne: true,
    crossPage: true,
    clickClose: false,
    enableKeyboardSafeArea: true,
  );
}
