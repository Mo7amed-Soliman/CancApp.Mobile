class ChatbotMessageModel {
  final String text;
  final bool isBot;
  final String timestamp;

  const ChatbotMessageModel({
    required this.text,
    required this.isBot,
    required this.timestamp,
  });

  static List<ChatbotMessageModel> getDummyMessages() {
    return [
      const ChatbotMessageModel(
        text: 'Minimum text check, Hide check icon',
        isBot: true,
        timestamp: '7:20 AM',
      ),
      const ChatbotMessageModel(
        text:
            'Rapidly build stunning Web Apps with Frest ⚡\nDeveloper friendly, Highly customizable & Carefully crafted HTML Admin Dashboard Template.',
        isBot: false,
        timestamp: '7:20 Am',
      ),
      const ChatbotMessageModel(
        text:
            'More no. of lines text and showing complete list of features like time stamp + check icon READ',
        isBot: true,
        timestamp: '7:20 AM',
      ),
      const ChatbotMessageModel(
        text: 'Minimum text check, Hide check icon',
        isBot: true,
        timestamp: '7:20 AM',
      ),
      const ChatbotMessageModel(
        text:
            'Rapidly build stunning Web Apps with Frest ⚡\nDeveloper friendly, Highly customizable & Carefully crafted HTML Admin Dashboard Template.',
        isBot: false,
        timestamp: '7:20 Am',
      ),
      const ChatbotMessageModel(
        text:
            'More no. of lines text and showing complete list of features like time stamp + check icon READ',
        isBot: true,
        timestamp: '7:20 AM',
      ),
      const ChatbotMessageModel(
        text: 'Minimum text check, Hide check icon',
        isBot: true,
        timestamp: '7:20 AM',
      ),
      const ChatbotMessageModel(
        text:
            'Rapidly build stunning Web Apps with Frest ⚡\nDeveloper friendly, Highly customizable & Carefully crafted HTML Admin Dashboard Template.',
        isBot: false,
        timestamp: '7:20 Am',
      ),
      const ChatbotMessageModel(
        text:
            'More no. of lines text and showing complete list of features like time stamp + check icon READ',
        isBot: true,
        timestamp: '7:20 AM',
      ),
    ];
  }
}
