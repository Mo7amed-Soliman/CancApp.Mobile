part of 'chat_bot_cubit.dart';

class ChatBotState extends Equatable {
  final List<ChatbotMessageModel> messages;
  final bool isLoading;
  final String? error;

  const ChatBotState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  ChatBotState copyWith({
    List<ChatbotMessageModel>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatBotState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading, error];
}
