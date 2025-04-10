import 'package:canc_app/users/patient/chat/presentation/views/widgets/chat_user_card.dart';
import 'package:flutter/material.dart';

class AvailableUsersList extends StatelessWidget {
  const AvailableUsersList({super.key});
  static const List<ChatUserCardModel> users = [
    ChatUserCardModel(
      name: 'Dr. Sara omar',
      address: '123 Main St, Anytown, USA',
      imagePath: 'assets/images/dummy_image/img1.png',
    ),
    ChatUserCardModel(
      name: 'Dr. Mohamed Ali',
      address: '123 Main St, Anytown, USA',
      imagePath: 'assets/images/dummy_image/img3.png',
    ),
    ChatUserCardModel(
      name: 'Dr. Sara omar',
      address: '123 Main St, Anytown, USA',
      imagePath: 'assets/images/dummy_image/img1.png',
    ),
    ChatUserCardModel(
      name: 'Dr. Mohamed Ali',
      address: '123 Main St, Anytown, USA',
      imagePath: 'assets/images/dummy_image/img3.png',
    ),
    ChatUserCardModel(
      name: 'Dr. Sara omar',
      address: '123 Main St, Anytown, USA',
      imagePath: 'assets/images/dummy_image/img1.png',
    ),
    ChatUserCardModel(
      name: 'Dr. Mohamed Ali',
      address: '123 Main St, Anytown, USA',
      imagePath: 'assets/images/dummy_image/img3.png',
    ),
    ChatUserCardModel(
      name: 'Dr. Sara omar',
      address: '123 Main St, Anytown, USA',
      imagePath: 'assets/images/dummy_image/img1.png',
    ),
    ChatUserCardModel(
      name: 'Dr. Mohamed Ali',
      address: '123 Main St, Anytown, USA',
      imagePath: 'assets/images/dummy_image/img3.png',
    ),
    ChatUserCardModel(
      name: 'Dr. Sara omar',
      address: '123 Main St, Anytown, USA',
      imagePath: 'assets/images/dummy_image/img1.png',
    ),
    ChatUserCardModel(
      name: 'Dr. Mohamed Ali',
      address: '123 Main St, Anytown, USA',
      imagePath: 'assets/images/dummy_image/img3.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ChatUserCard(
          model: users[index],
          onChatPressed: () {},
        );
      },
    );
  }
}
