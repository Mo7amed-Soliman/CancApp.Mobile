import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
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
  int currentLikes = 0;

  @override
  void initState() {
    super.initState();
    currentLikes = widget.comment.likes;
  }

  void _handleLike() {
    setState(() {
      isLiked = !isLiked;
      currentLikes = isLiked ? currentLikes + 1 : currentLikes - 1;
    });
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
              backgroundImage: AssetImage(widget.comment.userImageUrl),
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
                              widget.comment.commentTime,
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
                          currentLikes.toString(),
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
