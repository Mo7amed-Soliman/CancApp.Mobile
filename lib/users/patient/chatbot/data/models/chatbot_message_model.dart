class ChatbotMessageModel {
  final String text;
  final bool isBot;
  final String timestamp;

  const ChatbotMessageModel({
    required this.text,
    required this.isBot,
    required this.timestamp,
  });
}
