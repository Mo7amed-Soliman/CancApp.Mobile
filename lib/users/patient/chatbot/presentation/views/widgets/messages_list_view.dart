import 'package:flutter/material.dart';

import '../../../data/models/chatbot_message_model.dart';
import 'chatbot_message_bubble.dart';

class MessagesListView extends StatelessWidget {
  final List<ChatbotMessageModel> messages;
  final ScrollController scrollController;

  const MessagesListView({
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
          return TweenAnimationBuilder(
            duration: const Duration(milliseconds: 300),
            tween: Tween<double>(begin: 0.0, end: 1.0),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: 0.8 + (0.2 * value),
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
            child: ChatbotMessageBubble(
              message: messages[index],
            ),
          );
        },
      ),
    );
  }
}
