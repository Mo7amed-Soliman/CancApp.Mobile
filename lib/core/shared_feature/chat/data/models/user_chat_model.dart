class UserChatModel {
  final String name;
  final String imagePath;
  final String lastMessage;
  final String lastMessageTime;
  final String status;

  UserChatModel({
    required this.name,
    required this.imagePath,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.status,
  });

  static List<UserChatModel> getUsers() {
    return [
      UserChatModel(
        name: 'John Doe',
        imagePath: 'assets/images/dummy_image/img1.png',
        lastMessage: 'Hello, how are you?',
        lastMessageTime: '12:00 PM',
        status: 'Online',
      ),
    ];
  }
}
