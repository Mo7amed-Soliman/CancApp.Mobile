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
}
