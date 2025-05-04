import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/comment_item.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canc_app/core/shared_feature/community/manager/comment_cubit.dart';
import 'package:canc_app/core/shared_feature/community/manager/comment_state.dart';

class CommentsListView extends StatelessWidget {
  const CommentsListView({
    super.key,
    required this.post,
    this.scrollController,
  });

  final PostModel post;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit, CommentState>(
      builder: (context, state) {
        if (state is CommentLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CommentError) {
          return Center(child: Text(state.message));
        }

        if (state is CommentLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.setWidth(16),
                  vertical: context.setHeight(10),
                ),
                child: Text(
                  'Comments (${state.comments.length})',
                  style: AppTextStyle.font18SemiBoldDarkGray(context),
                ),
              ),
              const Divider(color: AppColors.lightGray, thickness: 2),
              const VerticalSpacer(5),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding:
                      EdgeInsets.symmetric(horizontal: context.setWidth(16)),
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    final comment = state.comments[index];
                    return CommentItem(
                      comment: comment,
                      onDelete: (commentId) =>
                          context.read<CommentCubit>().deleteComment(commentId),
                      onUpdate: (commentId, content) => context
                          .read<CommentCubit>()
                          .updateComment(commentId, content),
                      onLike: (commentId) =>
                          context.read<CommentCubit>().likeComment(commentId),
                      onDislike: (commentId) => context
                          .read<CommentCubit>()
                          .dislikeComment(commentId),
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
