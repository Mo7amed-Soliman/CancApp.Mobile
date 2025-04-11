import 'package:flutter/material.dart';
import 'chats_list_item.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    /// dummy data
    final chats = [
      const ChatsListItem(
        name: 'Salma Ali',
        message: 'Hey, how are you holding up today?',
        imageUrl: 'assets/images/dummy_image/img1.png',
      ),
      const ChatsListItem(
        name: 'Tarek mohamed',
        message: 'Hey, how are you holding up today?',
        imageUrl: 'assets/images/dummy_image/img3.png',
      ),
      const ChatsListItem(
        name: 'Sara omar',
        message: 'Hey, how are you holding up today?',
        imageUrl: 'assets/images/dummy_image/img2.png',
      ),
      const ChatsListItem(
        name: 'Mohamed Ali',
        message: 'Hey, how are you holding up today?',
        imageUrl: 'assets/images/dummy_image/img6.png',
      ),
      const ChatsListItem(
        name: 'Salma Ali',
        message: 'Hey, how are you holding up today?',
        imageUrl: 'assets/images/dummy_image/img1.png',
      ),
      const ChatsListItem(
        name: 'Tarek mohamed',
        message: 'Hey, how are you holding up today?',
        imageUrl: 'assets/images/dummy_image/img3.png',
      ),
      const ChatsListItem(
        name: 'Sara omar',
        message: 'Hey, how are you holding up today?',
        imageUrl: 'assets/images/dummy_image/img2.png',
      ),
      const ChatsListItem(
        name: 'Mohamed Ali',
        message: 'Hey, how are you holding up today?',
        imageUrl: 'assets/images/dummy_image/img6.png',
      ),
      const ChatsListItem(
        name: 'Salma Ali',
        message: 'Hey, how are you holding up today?',
        imageUrl: 'assets/images/dummy_image/img1.png',
      ),
      const ChatsListItem(
        name: 'Tarek mohamed',
        message: 'Hey, how are you holding up today?',
        imageUrl: 'assets/images/dummy_image/img3.png',
      ),
      const ChatsListItem(
        name: 'Sara omar',
        message: 'Hey, how are you holding up today?',
        imageUrl: 'assets/images/dummy_image/img2.png',
      ),
      const ChatsListItem(
        name: 'Mohamed Ali',
        message: 'Hey, how are you holding up today?',
        imageUrl: 'assets/images/dummy_image/img6.png',
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: chats.length,
      itemBuilder: (context, index) => chats[index],
    );
  }
}
