import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:canc_app/core/helpers/utils/app_assets.dart';
import 'package:canc_app/core/shared_feature/community/manager/comment_cubit.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({
    super.key,
    required this.comment,
    required this.onDelete,
    required this.onUpdate,
    required this.onLike,
    required this.onDislike,
  });

  final CommentModel comment;
  final Function(String) onDelete;
  final Function(String, String) onUpdate;
  final Function(String) onLike;
  final Function(String) onDislike;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  late bool isLiked;
  late bool isDisliked;
  late int currentLikes;
  late int currentDislikes;

  @override
  void initState() {
    super.initState();
    isLiked = widget.comment.isLiked;
    isDisliked = widget.comment.isDisliked;
    currentLikes = widget.comment.likesCount;
    currentDislikes = widget.comment.dislikesCount;
  }

  void _handleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        currentLikes++;
        if (isDisliked) {
          isDisliked = false;
          currentDislikes--;
        }
      } else {
        currentLikes--;
      }
    });
    widget.onLike(widget.comment.id);
  }

  void _handleDislike() {
    setState(() {
      isDisliked = !isDisliked;
      if (isDisliked) {
        currentDislikes++;
        if (isLiked) {
          isLiked = false;
          currentLikes--;
        }
      } else {
        currentDislikes--;
      }
    });
    widget.onDislike(widget.comment.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: context.setMinSize(22),
              backgroundImage: widget.comment.userImage != null
                  ? NetworkImage(widget.comment.userImage!)
                  : null,
              child: widget.comment.userImage == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            const HorizontalSpacer(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(
                      context.setWidth(12),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightGray,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.comment.userName,
                              style: AppTextStyle.font15Bold(context).copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.comment.createdAt.toString(),
                              style: AppTextStyle.font12MediumDarkGray(context),
                            ),
                            const HorizontalSpacer(5),
                            PopupMenuButton<String>(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 'edit',
                                  onTap: () {
                                    // TODO: Implement edit
                                  },
                                  child: const Text('Edit'),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  onTap: () =>
                                      widget.onDelete(widget.comment.id),
                                  child: const Text('Delete'),
                                ),
                              ],
                              child: Icon(
                                Icons.more_horiz,
                                size: context.setMinSize(20),
                                color: AppColors.darkGray,
                              ),
                            ),
                          ],
                        ),
                        const VerticalSpacer(5),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: widget.comment.content,
                                style:
                                    AppTextStyle.font14RegularDarkGray(context),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const VerticalSpacer(5),
                  Padding(
                    padding: EdgeInsets.only(
                      left: context.setWidth(10),
                      right: context.setWidth(10),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: _handleLike,
                          child: isLiked
                              ? Icon(
                                  Icons.favorite,
                                  color: AppColors.red,
                                  size: context.setMinSize(20),
                                )
                              : SvgPicture.asset(
                                  AppAssets.heartIcon,
                                  height: context.setMinSize(20),
                                ),
                        ),
                        const HorizontalSpacer(5),
                        Text(
                          currentLikes.toString(),
                          style: AppTextStyle.font14RegularDarkGray(context),
                        ),
                        const HorizontalSpacer(16),
                        GestureDetector(
                          onTap: _handleDislike,
                          child: Icon(
                            isDisliked
                                ? Icons.thumb_down
                                : Icons.thumb_down_outlined,
                            color: isDisliked
                                ? AppColors.primaryColor
                                : AppColors.darkGray,
                            size: context.setMinSize(20),
                          ),
                        ),
                        const HorizontalSpacer(5),
                        Text(
                          currentDislikes.toString(),
                          style: AppTextStyle.font14RegularDarkGray(context),
                        ),
                      ],
                    ),
                  ),
                  const VerticalSpacer(10),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
