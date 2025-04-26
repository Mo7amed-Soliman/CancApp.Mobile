import 'package:canc_app/core/helpers/class/date_helper.dart';
import 'package:canc_app/users/patient/chatbot/data/repositories/chatbot_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/chatbot_message_model.dart';

part 'chat_bot_state.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  final ChatBotRepository _chatbotRepository;

  ChatBotCubit({required ChatBotRepository chatbotRepository})
      : _chatbotRepository = chatbotRepository,
        super(const ChatBotState());

  Future<void> sendMessage(String message) async {
    final newMessage = ChatbotMessageModel(
      text: message,
      isBot: false,
      timestamp: DateHelper.formatTime(DateTime.now()),
    );

    emit(state.copyWith(
      messages: List.from(state.messages)..add(newMessage),
    ));

    await _botAutoReply(message);
  }

  Future<void> _botAutoReply(String message) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    final result = await _chatbotRepository.sendMessage(message);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          error: failure.errorMessage,
        ));
      },
      (response) {
        final botReply = ChatbotMessageModel(
          text: response,
          isBot: true,
          timestamp: DateHelper.formatTime(DateTime.now()),
        );

        emit(state.copyWith(
          isLoading: false,
          messages: List.from(state.messages)..add(botReply),
        ));
      },
    );
  }
}
