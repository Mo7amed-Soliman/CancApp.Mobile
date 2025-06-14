import 'package:canc_app/core/helpers/extension/time_ago_extension.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:flutter/material.dart';

import 'post_popup_menu.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({
    super.key,
    required this.post,
    required this.onDelete,
    required this.onEdit,
    required this.onReport,
  });

  final PostModel post;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onReport;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: context.setMinSize(24),
            backgroundImage: NetworkImage(post.userProfilePictureUrl),
          ),
          const HorizontalSpacer(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.name,
                  style: AppTextStyle.font17Medium(context).copyWith(),
                ),
                Text(
                  post.time.timeAgo,
                  style: AppTextStyle.font14RegularDarkGray(context),
                ),
              ],
            ),
          ),
          PostPopupMenu(
            userId: post.userId,
            onDelete: onDelete,
            onEdit: onEdit,
            onReport: onReport,
          ),
        ],
      ),
    );
  }
}
