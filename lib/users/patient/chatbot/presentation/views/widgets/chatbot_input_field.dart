import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/custom_text_field.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ChatbotInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  final bool isLoading;

  const ChatbotInputField({
    super.key,
    required this.controller,
    required this.onSend,
    this.isLoading = false,
  });

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
              controller: controller,
              hintText: S.of(context).message,
              textColor: AppColors.darkGray,
              hintColor: AppColors.grayish,
              fillColor: AppColors.lightGray,
              filled: true,
            ),
          ),
          const HorizontalSpacer(12),
          InkWell(
            onTap: isLoading ? null : onSend,
            child: CircleAvatar(
              radius: context.setMinSize(24),
              backgroundColor:
                  isLoading ? AppColors.grayish : AppColors.primaryColor,
              child: isLoading
                  ? SizedBox(
                      width: context.setMinSize(24),
                      height: context.setMinSize(24),
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : RotatedBox(
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
