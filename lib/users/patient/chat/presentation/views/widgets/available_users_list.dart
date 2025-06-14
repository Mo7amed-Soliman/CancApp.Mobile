// import 'package:canc_app/core/models/user_model.dart';
// import 'package:canc_app/core/routing/routes.dart';
// import 'package:canc_app/core/shared_feature/chat/data/models/user_chat_model.dart';
// import 'package:canc_app/users/patient/chat/presentation/views/widgets/chat_user_card.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class AvailableUsersList extends StatelessWidget {
//   const AvailableUsersList({super.key, required this.users});
//   final List<UserModel> users;

//   // UserChatModel _convertToUserModel(ChatUserCardModel cardModel) {
//   //   return UserChatModel(
//   //     name: cardModel.name,
//   //     imagePath: cardModel.imagePath,
//   //     lastMessage: 'Hey, how are you holding up today?',
//   //     id: cardModel.id,
//   //     idFrom: UserCacheHelper.getUser()?.id ?? '',
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: users.length,
//       itemBuilder: (context, index) {
//         final cardModel = users[index];
//         return ChatUserCard(
//           model: cardModel,
//           onChatPressed: () {
//             final user = _convertToUserModel(cardModel);
//             context.push(Routes.chatView, extra: user);
//           },
//         );
//       },
//     );
//   }
// }
