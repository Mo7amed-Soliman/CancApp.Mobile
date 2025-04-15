import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String content;
  final VoidCallback onConfirm;

  const DeleteConfirmationDialog({
    super.key,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: context.setMinSize(50),
      ),
      backgroundColor: AppColors.offWhite,
      contentPadding: EdgeInsets.symmetric(
        horizontal: context.setMinSize(25),
        vertical: context.setMinSize(15),
      ),
      actionsPadding: EdgeInsets.only(
        bottom: context.setMinSize(20),
      ),
      content: Text(
        content,
        style: AppTextStyle.font16MediumDarkGray(context).copyWith(
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: context.setMinSize(20),
              vertical: context.setMinSize(8),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: AppColors.primaryColor),
            ),
          ),
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            'Cancel',
            style: AppTextStyle.font16RegularDarkGray(context).copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: context.setMinSize(20),
              vertical: context.setMinSize(8),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.red),
            ),
          ),
          onPressed: () {
            Navigator.pop(context, true);
            onConfirm();
          },
          child: Text(
            'Delete',
            style: AppTextStyle.font16RegularDarkGray(context).copyWith(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  static Future<bool> show(
    BuildContext context, {
    required String content,
    required VoidCallback onConfirm,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        content: content,
        onConfirm: onConfirm,
      ),
    );
    return confirmed ?? false;
  }
}
