class UserChatModel {
  final String name;
  final String imagePath;
  final String lastMessage;
  final String id;
  final String idFrom;

  UserChatModel({
    required this.name,
    required this.id,
    required this.idFrom,
    required this.imagePath,
    required this.lastMessage,
  });
}
