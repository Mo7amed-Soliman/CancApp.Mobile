import 'package:canc_app/core/widgets/in_empty_list.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import '../../../data/models/chat_message_model.dart';
import 'message_bubble.dart';

class ChatBody extends StatelessWidget {
  final List<ChatMessageModel> messages;
  final ScrollController scrollController;

  const ChatBody({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: messages.isEmpty
          ? const InEmptyList(
              title:
                  'No messages yet\n Send a message to start the conversation',
            )
          : ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: context.setMinSize(16),
                vertical: context.setMinSize(16),
              ),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  chatMessageModel: messages[index],
                );
              },
            ),
    );
  }
}
