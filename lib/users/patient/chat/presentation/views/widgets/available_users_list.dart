import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/chat/data/models/user_chat_model.dart';
import 'package:canc_app/users/patient/chat/presentation/views/widgets/chat_user_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  UserChatModel _convertToUserModel(ChatUserCardModel cardModel) {
    return UserChatModel(
      name: cardModel.name,
      imagePath: cardModel.imagePath,
      lastMessage: '',
      lastMessageTime: '',
      status: 'Online',
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final cardModel = users[index];
        return ChatUserCard(
          model: cardModel,
          onChatPressed: () {
            final user = _convertToUserModel(cardModel);
            context.push(Routes.chatView, extra: user);
          },
        );
      },
    );
  }
}
