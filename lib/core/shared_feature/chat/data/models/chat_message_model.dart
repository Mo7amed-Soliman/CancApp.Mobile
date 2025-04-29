enum TypeMessage {
  text,
  image,
}

class ChatMessageModel {
  final String text;
  final String idTo;
  final String idFrom;
  final bool isMe;
  final String timestamp;
  final TypeMessage type;

  ChatMessageModel({
    required this.text,
    required this.isMe,
    required this.timestamp,
    required this.type,
    required this.idTo,
    required this.idFrom,
  });

  static List<ChatMessageModel> getMessages() {
    return [
      ChatMessageModel(
        text: 'Hi,Doctor.',
        isMe: true,
        timestamp: '1:20 AM',
        type: TypeMessage.text,
        idTo: '1',
        idFrom: '2',
      ),
      ChatMessageModel(
        text: 'Hello,How are you today ?',
        isMe: false,
        timestamp: '1:20 AM',
        type: TypeMessage.text,
        idTo: '1',
        idFrom: '2',
      ),
      ChatMessageModel(
        text: "I've been feeling weak and having trouble sleeping.",
        isMe: true,
        timestamp: '1:21 AM',
        type: TypeMessage.text,
        idTo: '1',
        idFrom: '2',
      ),
      ChatMessageModel(
        text: "That's normal during treatment are the medications helping ?",
        isMe: false,
        timestamp: '1:22 AM',
        type: TypeMessage.text,
        idTo: '1',
        idFrom: '2',
      ),
      ChatMessageModel(
        text: 'A little, but the nausea is still bad.',
        isMe: true,
        timestamp: '1:22 AM',
        type: TypeMessage.text,
        idTo: '1',
        idFrom: '2',
      ),
      ChatMessageModel(
        text: "I'll adjust your prescription to help with that.",
        isMe: false,
        timestamp: '1:23 AM',
        type: TypeMessage.text,
        idTo: '1',
        idFrom: '2',
      ),
      ChatMessageModel(
        text: 'Thank you .will this get easier ?',
        isMe: true,
        timestamp: '1:24 AM',
        type: TypeMessage.text,
        idTo: '1',
        idFrom: '2',
      ),
    ];
  }
}
