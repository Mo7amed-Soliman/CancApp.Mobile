import 'package:flutter/material.dart';

import '../../../data/models/chatbot_message_model.dart';
import 'chatbot_message_bubble.dart';

class ChatBotBody extends StatelessWidget {
  final List<ChatbotMessageModel> messages;
  final ScrollController scrollController;

  const ChatBotBody({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ChatbotMessageBubble(
            message: messages[index],
          );
        },
      ),
    );
  }
}
