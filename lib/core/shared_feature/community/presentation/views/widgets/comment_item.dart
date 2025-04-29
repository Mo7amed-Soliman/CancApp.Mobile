import 'package:canc_app/core/helpers/functions/is_arabic.dart';
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
    this.isReply = false,
  });

  final CommentModel comment;
  final bool isReply;
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
              radius: widget.isReply
                  ? context.setMinSize(16)
                  : context.setMinSize(22),
              backgroundImage: AssetImage(widget.comment.userImageUrl),
            ),
            widget.isReply
                ? const HorizontalSpacer(6)
                : const HorizontalSpacer(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(
                      widget.isReply
                          ? context.setWidth(8)
                          : context.setWidth(12),
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
                              if (widget.isReply)
                                TextSpan(
                                  text: '@${widget.comment.replyName} ',
                                  style:
                                      AppTextStyle.font15Bold(context).copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
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
                        const HorizontalSpacer(20),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Reply',
                            style: AppTextStyle.font14RegularDarkGray(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalSpacer(8),
                ],
              ),
            ),
          ],
        ),
        // Display replies if any
        if (widget.comment.replies != null &&
            widget.comment.replies!.isNotEmpty)
          ...widget.comment.replies!.map(
            (reply) => Padding(
              padding: EdgeInsets.only(
                left: isArabic() ? 0 : context.setMinSize(30),
                right: isArabic() ? context.setMinSize(30) : 0,
              ),
              child: CommentItem(
                comment: reply,
                isReply: true,
              ),
            ),
          ),
      ],
    );
  }
}
