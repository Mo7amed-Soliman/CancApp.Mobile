import 'package:canc_app/core/helpers/utils/app_assets.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
import 'package:canc_app/core/shared_feature/community/manager/comment_cubit.dart';
import 'package:canc_app/core/shared_feature/community/manager/comment_state.dart';
import 'package:canc_app/core/shared_feature/community/presentation/widgets/comment_input_field.dart';
import 'package:canc_app/core/shared_feature/community/presentation/widgets/comments_list_view.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CommentView extends StatelessWidget {
  final String postId;

  const CommentView({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentCubit(
        repository: context.read(),
        postId: postId,
      )..getComments(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Comments',
            style: AppTextStyle.font19MediumDarkGray(context),
          ),
          backgroundColor: AppColors.offWhite,
        ),
        body: BlocBuilder<CommentCubit, CommentState>(
          builder: (context, state) {
            if (state is CommentLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CommentError) {
              return Center(
                child: Text(
                  state.message,
                  style: AppTextStyle.font15Medium(context),
                ),
              );
            }

            if (state is CommentLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: CommentsListView(
                      comments: state.comments,
                      onDelete: (commentId) =>
                          context.read<CommentCubit>().deleteComment(commentId),
                      onUpdate: (commentId, content) =>
                          context.read<CommentCubit>().updateComment(
                                commentId,
                                content,
                              ),
                      onLike: (commentId) =>
                          context.read<CommentCubit>().likeComment(commentId),
                      onDislike: (commentId) => context
                          .read<CommentCubit>()
                          .dislikeComment(commentId),
                    ),
                  ),
                  CommentInputField(
                    postId: postId,
                    onCommentAdded: (content, userId) =>
                        context.read<CommentCubit>().addComment(
                              content,
                              userId,
                            ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
