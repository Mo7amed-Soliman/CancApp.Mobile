import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/users/patient/chatbot/data/models/chatbot_message_model.dart';

class ChatbotMessageBubble extends StatelessWidget {
  final ChatbotMessageModel message;

  const ChatbotMessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
          bottom: context.setMinSize(8),
          left: message.isBot ? context.setMinSize(16) : context.setMinSize(64),
          right:
              message.isBot ? context.setMinSize(64) : context.setMinSize(16),
          top: context.setMinSize(8),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.setMinSize(16),
          vertical: context.setMinSize(12),
        ),
        decoration: BoxDecoration(
          color: message.isBot
              ? AppColors.lightGray
              : AppColors.primaryColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(context.setMinSize(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.text,
              style: AppTextStyle.font14RegularDarkGray(context),
            ),
            const VerticalSpacer(4),
            Text(
              message.timestamp,
              style: AppTextStyle.font12MediumDarkGray(context).copyWith(
                color: AppColors.grayish,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
