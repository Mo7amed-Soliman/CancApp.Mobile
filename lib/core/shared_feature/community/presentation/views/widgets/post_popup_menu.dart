import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository.dart';
import 'package:canc_app/core/di/dependency_injection.dart';

class PostPopupMenu extends StatelessWidget {
  const PostPopupMenu({
    super.key,
    required this.post,
    required this.onDelete,
  });

  final PostModel post;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = UserCacheHelper.getUser()?.id == post.userId;
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      offset: Offset(0, context.setHeight(32)),
      itemBuilder: (context) => [
        if (isCurrentUser)
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
        if (isCurrentUser)
          PopupMenuItem(
            value: 'delete',
            onTap: () async {
              final repository = getIt<CommunityRepository>();
              try {
                final result = await repository.deletePost(postId: post.id);
                result.fold(
                  (failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(failure.errorMessage)),
                    );
                  },
                  (_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Post deleted successfully')),
                    );
                    onDelete();
                  },
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
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
        if (!isCurrentUser)
          PopupMenuItem(
            value: 'report',
            onTap: () async {
              final repository = getIt<CommunityRepository>();
              try {
                final result = await repository.reportPost(postId: post.id);
                result.fold(
                  (failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(failure.errorMessage)),
                    );
                  },
                  (_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Post reported successfully')),
                    );
                  },
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
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
