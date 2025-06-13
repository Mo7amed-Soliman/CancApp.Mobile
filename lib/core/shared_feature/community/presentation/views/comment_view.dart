import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/app_assets.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/presentation/manager/comment_cubit/comment_cubit.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/comment_input_field.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/comment_shimmer.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/comments_list_view.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/in_empty_list.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canc_app/generated/l10n.dart';

class CommentView extends StatefulWidget {
  const CommentView({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  @override
  void initState() {
    super.initState();

    if (widget.post.commentsCount > 0) {
      _loadComments();
    }
  }

  void _loadComments() {
    context.read<CommentCubit>().loadComments(postId: widget.post.id);
  }

  @override
  Widget build(BuildContext context) {
    final commentCubit = context.read<CommentCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.offWhite,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<CommentCubit, CommentState>(
                builder: (context, state) {
                  return switch (state) {
                    CommentLoading() => Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.setWidth(16),
                              vertical: context.setHeight(10),
                            ),
                            child: Text(
                              '${S.of(context).comments} (${widget.post.commentsCount})',
                              style:
                                  AppTextStyle.font18SemiBoldDarkGray(context),
                            ),
                          ),
                          const Divider(
                              color: AppColors.lightGray, thickness: 2),
                          const VerticalSpacer(5),
                          const CommentsShimmerLoading(),
                        ],
                      ),
                    CommentError(errorMessage: final message) => Center(
                        child: Text(
                          message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    CommentSuccess(comments: final comments) => comments.isEmpty
                        ? Center(
                            child: InEmptyList(
                              title: S.of(context).noComments,
                              image: AppAssets.noComments,
                            ),
                          )
                        : CommentsListView(
                            post: widget.post,
                            comments: commentCubit.listOfComments,
                          ),
                    _ => Center(
                        child: InEmptyList(
                          title: S.of(context).noComments,
                          image: AppAssets.noComments,
                        ),
                      ),
                  };
                },
              ),
            ),
            CommentInputField(
              postId: widget.post.id,
              onCommentAdded: (content) {
                commentCubit.addComment(
                  postId: widget.post.id,
                  content: content,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
