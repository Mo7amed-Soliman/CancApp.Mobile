import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/chat_bot_cubit.dart';
import 'animated_chatbot_welcome.dart';
import 'chatbot_input_field.dart';
import 'messages_list_view.dart';

class ChatBotViewBody extends StatefulWidget {
  const ChatBotViewBody({super.key});

  @override
  State<ChatBotViewBody> createState() => _ChatBotViewBodyState();
}

class _ChatBotViewBodyState extends State<ChatBotViewBody>
    with WidgetsBindingObserver {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBotCubit, ChatBotState>(
      listenWhen: (previous, current) => previous.error != current.error,
      listener: (context, state) {
        if (state.error != null) botTextToast(state.error!);
      },
      child: Column(
        children: [
          BlocBuilder<ChatBotCubit, ChatBotState>(
            builder: (context, state) {
              final messages = state.messages;
              if (messages.isEmpty) {
                return const Expanded(
                  child: AnimatedChatbotWelcome(),
                );
              }
              return MessagesListView(
                messages: messages,
                scrollController: _scrollController,
              );
            },
          ),
          ChatbotInputField(
            controller: _messageController,
            onSend: _handleSend,
            isLoading: context.watch<ChatBotCubit>().state.isLoading,
          ),
        ],
      ),
    );
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

  void _handleSend() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    _messageController.clear();

    await context.read<ChatBotCubit>().sendMessage(text);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }
}
