import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/comment_item.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';

class CommentsListView extends StatelessWidget {
  const CommentsListView({
    super.key,
    required this.post,
    required this.comments,
    this.scrollController,
  });

  final PostModel post;
  final List<CommentModel> comments;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.setWidth(16),
            vertical: context.setHeight(10),
          ),
          child: Text(
            'Comments (${comments.length})',
            style: AppTextStyle.font18SemiBoldDarkGray(context),
          ),
        ),
        const Divider(color: AppColors.lightGray, thickness: 2),
        const VerticalSpacer(5),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: context.setWidth(16)),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return CommentItem(
                comment: comments[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
