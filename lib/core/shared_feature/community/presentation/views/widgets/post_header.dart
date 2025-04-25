import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

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
          PostPopupMenu(post: post),
        ],
      ),
    );
  }
}

class PostPopupMenu extends StatelessWidget {
  const PostPopupMenu({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      offset: Offset(0, context.setHeight(32)),
      itemBuilder: (context) => [
        // TODO: change to current user id
        if (post.userId == '1')
          PopupMenuItem(
            value: 'edit',
            onTap: () {},
            child: Row(
              children: [
                const Icon(
                  IconlyLight.edit,
                  color: AppColors.darkGray,
                ),
                const HorizontalSpacer(12),
                Text(
                  S.of(context).edit,
                  style: AppTextStyle.font15Bold(context).copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkGray,
                  ),
                ),
              ],
            ),
          ),
        // TODO: change to current user id
        if (post.userId == '1')
          PopupMenuItem(
            value: 'delete',
            onTap: () {},
            child: Row(
              children: [
                const Icon(
                  IconlyLight.delete,
                  color: AppColors.darkGray,
                ),
                const HorizontalSpacer(12),
                Text(
                  S.of(context).delete,
                  style: AppTextStyle.font15Bold(context).copyWith(
                    color: AppColors.darkGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        PopupMenuItem(
          value: 'report',
          onTap: () {},
          child: Row(
            children: [
              const Icon(
                IconlyLight.info_circle,
                color: AppColors.red,
              ),
              const HorizontalSpacer(12),
              Text(
                S.of(context).report,
                style: AppTextStyle.font15Bold(context).copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
