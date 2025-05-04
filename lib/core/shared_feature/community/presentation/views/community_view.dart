import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/shared_feature/community/data/data_sources/community_data_source.dart';
import 'package:canc_app/core/shared_feature/community/data/data_sources/community_remote_data_source.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository_impl.dart';
import 'package:canc_app/core/shared_feature/community/manager/community_cubit.dart';
import 'package:canc_app/core/shared_feature/community/manager/community_state.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'widgets/community_header.dart';
import 'widgets/list_view_of_posts.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunityCubit(
        repository: CommunityRepositoryImpl(
          dataSource: CommunityRemoteDataSource(
            apiConsumer: getIt<ApiConsumer>(),
          ),
        ),
      )..loadPosts(),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: SafeArea(
          child: Column(
            children: [
              const CommunityHeader(),
              Expanded(
                child: BlocBuilder<CommunityCubit, CommunityState>(
                  builder: (context, state) {
                    if (state is CommunityLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
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
        ),
      ),
    );
  }
}
