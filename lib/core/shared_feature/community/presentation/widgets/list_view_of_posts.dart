import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ListOfPosts extends StatelessWidget {
  final List<PostModel> posts;
  final bool hasMorePosts;
  final VoidCallback onLoadMore;
  final Function(String) onLike;
  final Function(String) onDislike;
  final Function(String) onDelete;

  const ListOfPosts({
    super.key,
    required this.posts,
    required this.hasMorePosts,
    required this.onLoadMore,
    required this.onLike,
    required this.onDislike,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length + (hasMorePosts ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == posts.length) {
          return Center(
            child: TextButton(
              onPressed: onLoadMore,
              child: Text(
                'Load More',
                style: AppTextStyle.font15Medium(context).copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          );
        }

        final post = posts[index];
        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.offWhite,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.darkGray.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: post.userImage != null
                        ? NetworkImage(post.userImage!)
                        : null,
                    child: post.userImage == null
                        ? const Icon(IconlyLight.profile)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.userName,
                          style: AppTextStyle.font15Bold(context),
                        ),
                        Text(
                          post.createdAt.toString(),
                          style: AppTextStyle.font15Medium(context).copyWith(
                            color: AppColors.darkGray.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => onDelete(post.id),
                    icon: const Icon(
                      IconlyLight.delete,
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (post.content.isNotEmpty)
                Text(
                  post.content,
                  style: AppTextStyle.font15Medium(context),
                ),
              if (post.image != null) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    post.image!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  IconButton(
                    onPressed: () => onLike(post.id),
                    icon: Icon(
                      post.isLiked ? IconlyBold.heart : IconlyLight.heart,
                      color: post.isLiked ? AppColors.red : AppColors.darkGray,
                    ),
                  ),
                  Text(
                    post.likesCount.toString(),
                    style: AppTextStyle.font15Medium(context),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: () => onDislike(post.id),
                    icon: Icon(
                      post.isDisliked
                          ? IconlyBold.discovery
                          : IconlyLight.discovery,
                      color: post.isDisliked
                          ? AppColors.primaryColor
                          : AppColors.darkGray,
                    ),
                  ),
                  Text(
                    post.dislikesCount.toString(),
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
