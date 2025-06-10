import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/helpers/extension/time_ago_extension.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:canc_app/core/helpers/utils/app_assets.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({
    super.key,
    required this.comment,
  });

  final CommentModel comment;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool isLiked = false;
  final CommunityRepository _repository = getIt<CommunityRepository>();
  int reactionsCount = 0;

  @override
  void initState() {
    super.initState();
    reactionsCount = widget.comment.reactionsCount;
  }

  Future<void> _handleLike() async {
    setState(() {
      isLiked = !isLiked;
    });

    try {
      /// check if the user liked the comment
      /// if the user liked the comment, add reaction
      reactionsCount = isLiked ? reactionsCount + 1 : reactionsCount - 1;

      final result = isLiked

          /// add reaction
          ? await _repository.addReaction(
              postId: widget.comment.postId.toString(),
              isComment: true,
              commentId: widget.comment.id.toString(),
              userId: UserCacheHelper.getUser()?.id ?? '',
            )

          /// delete reaction
          : await _repository.deleteReaction(
              postId: widget.comment.postId,
              isComment: true,
              commentId: widget.comment.id,
              userId: UserCacheHelper.getUser()?.id ?? '',
            );

      result.fold(
        (failure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(failure.errorMessage)),
            );
            // Revert the UI state on failure
            setState(() {
              isLiked = !isLiked;
            });
          }
        },
        (_) {
          // Success - UI state is already updated
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
        // Revert the UI state on error
        setState(() {
          isLiked = !isLiked;
        });
      }
    }
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
              backgroundImage: NetworkImage(widget.comment.userImageUrl),
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
                              widget.comment.name,
                              style: AppTextStyle.font15Bold(context).copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.comment.time.timeAgo,
                              style: AppTextStyle.font12MediumDarkGray(context),
                            ),
                            const HorizontalSpacer(5),
                            Icon(
                              Icons.more_horiz,
                              size: context.setMinSize(20),
                              color: AppColors.darkGray,
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
                          reactionsCount.toString(),
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
