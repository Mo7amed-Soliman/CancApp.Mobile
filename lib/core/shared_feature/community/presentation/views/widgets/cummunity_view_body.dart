import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart'
    show PostModel;
import 'package:canc_app/core/shared_feature/community/manager/community_cubit.dart';
import 'package:canc_app/core/shared_feature/community/manager/community_state.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/community_header.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redacted/redacted.dart';

import 'custom_post_widget.dart';
import 'list_view_of_posts.dart';

class CummunityViewBody extends StatelessWidget {
  const CummunityViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CommunityHeader(),
          Expanded(
            child: BlocBuilder<CommunityCubit, CommunityState>(
              builder: (context, state) {
                if (state is CommunityLoading) {
                  return const Center(child:  CircularProgressIndicator());
                }

                if (state is CommunityError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: AppTextStyle.font17Medium(context),
                    ),
                  );
                }

                if (state is CommunityLoaded) {
                  return ListOfPosts(
                    posts: state.posts,
                    hasMorePosts: state.hasMorePosts,
                    onLoadMore: () =>
                        context.read<CommunityCubit>().loadMorePosts(),
                    onLike: (postId) =>
                        context.read<CommunityCubit>().likePost(postId),
                    onDislike: (postId) =>
                        context.read<CommunityCubit>().dislikePost(postId),
                    onDelete: (postId) =>
                        context.read<CommunityCubit>().deletePost(postId),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
