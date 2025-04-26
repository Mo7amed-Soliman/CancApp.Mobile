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

  List<TextSpan> _parseText(String text, BuildContext context) {
    final List<TextSpan> spans = [];
    final RegExp boldPattern = RegExp(r'\*\*(.*?)\*\*');
    int lastIndex = 0;

    for (final match in boldPattern.allMatches(text)) {
      // Add text before the bold section
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: text.substring(lastIndex, match.start),
          style: AppTextStyle.font14RegularDarkGray(context),
        ));
      }

      // Add the bold text
      spans.add(TextSpan(
        text: match.group(1),
        style: AppTextStyle.font14RegularDarkGray(context).copyWith(
          fontWeight: FontWeight.bold,
        ),
      ));

      lastIndex = match.end;
    }

    // Add any remaining text
    if (lastIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastIndex),
        style: AppTextStyle.font14RegularDarkGray(context),
      ));
    }

    return spans;
  }

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
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(message.isBot ? 0 : 16),
            bottomRight: Radius.circular(message.isBot ? 16 : 0),
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                children: _parseText(message.text, context),
              ),
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
