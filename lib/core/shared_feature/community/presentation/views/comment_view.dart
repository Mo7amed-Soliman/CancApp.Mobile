import 'package:canc_app/core/helpers/utils/app_assets.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/comment_input_field.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/comments_list_view.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/in_empty_list.dart';
import 'package:flutter/material.dart';

class CommentView extends StatelessWidget {
  const CommentView({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.offWhite,
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (post.commentsList != null && post.commentsList!.isNotEmpty)
              Expanded(
                child: CommentsListView(
                  post: post,
                ),
              )
            else ...[
              const Spacer(),
              const Center(
                child: InEmptyList(
                  title: 'No comments yet \n Be the first to comment',
                  image: AppAssets.noComments,
                ),
              ),
              const Spacer(),
            ],
            CommentInputField(postId: post.postId),
          ],
        ),
      ),
    );
  }
}
