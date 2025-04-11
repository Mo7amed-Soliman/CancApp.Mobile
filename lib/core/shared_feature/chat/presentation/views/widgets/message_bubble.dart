import 'dart:io';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../data/models/chat_message_model.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessageModel chatMessageModel;

  const MessageBubble({
    super.key,
    required this.chatMessageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          chatMessageModel.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: context.setMinSize(8),
          left: chatMessageModel.isMe ? context.setMinSize(64) : 0,
          right: chatMessageModel.isMe ? 0 : context.setMinSize(64),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.setMinSize(16),
          vertical: context.setMinSize(12),
        ),
        decoration: BoxDecoration(
          color: chatMessageModel.isMe
              ? AppColors.paleTealTransparent
              : AppColors.lightGray,
          borderRadius: BorderRadius.circular(context.setMinSize(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (chatMessageModel.type == TypeMessage.text)
              Text(
                chatMessageModel.text,
                style: AppTextStyle.font14RegularDarkGray(context),
              )
            else if (chatMessageModel.type == TypeMessage.image)
              ClipRRect(
                borderRadius: BorderRadius.circular(context.setMinSize(8)),
                child: chatMessageModel.text.startsWith('http')
                    ? Image.network(
                        chatMessageModel.text,
                        width: context.setMinSize(200),
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SizedBox(
                            width: context.setMinSize(200),
                            height: context.setMinSize(150),
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: context.setMinSize(200),
                            height: context.setMinSize(150),
                            color: AppColors.lightGray,
                            child: const Icon(
                              Icons.error_outline,
                              color: AppColors.grayish,
                            ),
                          );
                        },
                      )
                    : Image.file(
                        File(chatMessageModel.text),
                        width: context.setMinSize(200),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: context.setMinSize(200),
                            height: context.setMinSize(150),
                            color: AppColors.lightGray,
                            child: const Icon(
                              Icons.error_outline,
                              color: AppColors.grayish,
                            ),
                          );
                        },
                      ),
              ),
            SizedBox(height: context.setMinSize(4)),
            Text(
              chatMessageModel.timestamp,
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
