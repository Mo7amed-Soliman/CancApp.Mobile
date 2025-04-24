import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: context.setMinSize(24),
            backgroundImage: AssetImage(post.userImageUrl),
          ),
          const HorizontalSpacer(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.userName,
                  style: AppTextStyle.font17Medium(context).copyWith(),
                ),
                Text(
                  post.postTime.toString(),
                  style: AppTextStyle.font14RegularDarkGray(context),
                ),
              ],
            ),
          ),
          RotatedBox(
            quarterTurns: 1,
            child: IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: const Color(0xFF757575),
                size: context.setMinSize(26),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
