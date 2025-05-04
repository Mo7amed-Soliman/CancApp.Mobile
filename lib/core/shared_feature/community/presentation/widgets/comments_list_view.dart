import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CommentsListView extends StatelessWidget {
  final List<CommentModel> comments;
  final Function(String) onDelete;
  final Function(String, String) onUpdate;
  final Function(String) onLike;
  final Function(String) onDislike;

  const CommentsListView({
    super.key,
    required this.comments,
    required this.onDelete,
    required this.onUpdate,
    required this.onLike,
    required this.onDislike,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.offWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: comment.userImage != null
                        ? NetworkImage(comment.userImage!)
                        : null,
                    child: comment.userImage == null
                        ? const Icon(IconlyLight.profile)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.userName,
                          style: AppTextStyle.font15Bold(context),
                        ),
                        Text(
                          comment.createdAt.toString(),
                          style: AppTextStyle.font15Medium(context).copyWith(
                            color: AppColors.darkGray.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => onDelete(comment.id),
                    icon: const Icon(
                      IconlyLight.delete,
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                comment.content,
                style: AppTextStyle.font15Medium(context),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  IconButton(
                    onPressed: () => onLike(comment.id),
                    icon: Icon(
                      comment.isLiked ? IconlyBold.heart : IconlyLight.heart,
                      color:
                          comment.isLiked ? AppColors.red : AppColors.darkGray,
                    ),
                  ),
                  Text(
                    comment.likesCount.toString(),
                    style: AppTextStyle.font15Medium(context),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: () => onDislike(comment.id),
                    icon: Icon(
                      comment.isDisliked
                          ? IconlyBold.discovery
                          : IconlyLight.discovery,
                      color: comment.isDisliked
                          ? AppColors.primaryColor
                          : AppColors.darkGray,
                    ),
                  ),
                  Text(
                    comment.dislikesCount.toString(),
                    style: AppTextStyle.font15Medium(context),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
