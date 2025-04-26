import 'package:canc_app/core/helpers/class/date_helper.dart';
import 'package:flutter/material.dart';

import '../../data/models/chatbot_message_model.dart';
import 'widgets/animated_chatbot_welcome.dart';
import 'widgets/chatbot_body.dart';
import 'widgets/chatbot_input_field.dart';
import 'widgets/custom_app_bar_chatbot.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> with WidgetsBindingObserver {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatbotMessageModel> _messages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _handleSend() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatbotMessageModel(
          text: _messageController.text,
          isBot: false,
          timestamp: DateHelper.formatTime(DateTime.now()),
        ),
      );
    });

    _messageController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarChatBot(),
      body: Column(
        children: [
          if (_messages.isEmpty) ...[
            const Spacer(),
            const AnimatedChatbotWelcome(),
          ],
          ChatBotBody(
            messages: _messages,
            scrollController: _scrollController,
          ),
          ChatbotInputField(
            controller: _messageController,
            onSend: _handleSend,
          ),
        ],
      ),
    );
  }
}
