import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manger/chat_bot_cubit.dart';
import 'widgets/chatbot_view_body.dart';
import 'widgets/custom_app_bar_chatbot.dart';

class ChatBotView extends StatelessWidget {
  const ChatBotView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatBotCubit>(),
      child: const Scaffold(
        appBar: CustomAppBarChatBot(),
        body: ChatBotViewBody(),
      ),
    );
  }
}
