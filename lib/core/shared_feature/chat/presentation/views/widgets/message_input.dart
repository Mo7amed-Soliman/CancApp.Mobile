import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/custom_text_field.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({
    super.key,
    required this.controller,
    required this.onSendPressed,
    required this.onImagePressed,
    required this.focusNode,
  });

  final TextEditingController controller;
  final VoidCallback onSendPressed;
  final VoidCallback onImagePressed;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.setMinSize(16),
        vertical: context.setMinSize(8),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              focusNode: focusNode,
              controller: controller,
              hintText: S.of(context).message,
              textColor: AppColors.darkGray,
              hintColor: AppColors.grayish,
              fillColor: AppColors.lightGray,
              filled: true,
              suffixIcon: IconButton(
                onPressed: onImagePressed,
                icon: Icon(
                  IconlyLight.camera,
                  color: AppColors.grayish,
                  size: context.setMinSize(28),
                ),
              ),
            ),
          ),
          SizedBox(width: context.setMinSize(8)),
          InkWell(
            onTap: onSendPressed,
            child: CircleAvatar(
              radius: context.setMinSize(24),
              backgroundColor: AppColors.primaryColor,
              child: RotatedBox(
                quarterTurns: isArabic() ? 3 : 4,
                child: Icon(
                  IconlyLight.send,
                  color: Colors.white,
                  size: context.setMinSize(24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
