import 'package:canc_app/core/models/user_model.dart';
import 'package:flutter/material.dart';
import 'chats_list_item.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key, required this.users});
  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) => ChatsListItem(
        user: users[index],
      ),
    );
  }
}
