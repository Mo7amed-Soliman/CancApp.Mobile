import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/chat/data/models/user_chat_model.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatsListItem extends StatelessWidget {
  final String name;
  final String message;
  final String imageUrl;

  const ChatsListItem({
    super.key,
    required this.name,
    required this.message,
    required this.imageUrl,
  });

  UserChatModel _createUserModel() {
    return UserChatModel(
      name: name,
      imagePath: imageUrl,
      lastMessage: message,
      lastMessageTime: '12:00 PM',
      status: 'Online',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.setMinSize(16)),
      child: InkWell(
        onTap: () {
          final user = _createUserModel();
          context.push(Routes.chatView, extra: user);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: context.setMinSize(28),
              backgroundImage: AssetImage(imageUrl),
            ),
            const HorizontalSpacer(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyle.font16MediumDarkGray(context).copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const VerticalSpacer(4),
                  Text(
                    message,
                    style: AppTextStyle.font12MediumDarkGray(context).copyWith(
                      color: AppColors.grayish,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
