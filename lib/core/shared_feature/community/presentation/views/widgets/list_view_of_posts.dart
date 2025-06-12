import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/shared_feature/community/presentation/manager/community_cubit.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/post_item.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/post_shimmer.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/delete_confirmation_dialog.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfPosts extends StatefulWidget {
  const ListOfPosts({super.key});

  @override
  State<ListOfPosts> createState() => _ListOfPostsState();
}

class _ListOfPostsState extends State<ListOfPosts> {
  late ScrollController _scrollController;
  int _currentPage = 2;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<CommunityCubit>().getPosts();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommunityCubit, CommunityState>(
      listener: (context, state) => _handleStateChanges(state),
      builder: (context, state) {
        final posts = context.read<CommunityCubit>().listOfPosts;
        if (_shouldShowPostsList(state)) {
          return Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<CommunityCubit>().getPosts(
                      pageNumber: 1,
                      isRefresh: true,
                    );
                _currentPage = 2;
              },
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverList.builder(
                    itemBuilder: (context, index) {
                      if (index < posts.length) {
                        final post = posts[index];
                        return PostItem(
                          key: ValueKey(post.id),
                          post: post,
                          onDelete: () => _handleDeletePost(index),
                          onEdit: () {
                            // TODO: Implement edit functionality
                          },
                          onReport: () {
                            context.read<CommunityCubit>().reportPost(post.id);
                          },
                        );
                      } else {
                        return const PostShimmer();
                      }
                    },
                    itemCount: posts.length + (isLoading ? 2 : 0),
                  ),
                ],
              ),
            ),
          );
        } else if (state is CommunityPostsError) {
          return Center(child: Text(state.message));
        } else {
          return const PostsShimmerLoadingList();
        }
      },
    );
  }

  bool _shouldShowPostsList(CommunityState state) {
    return state is! CommunityPostLoading &&
        state is! CommunityPostsPaginationLoading &&
        state is! CommunityPostsError;
  }

  void _handleStateChanges(CommunityState state) {
    if (state is CommunityPostsError) {
      botTextToast(state.message);
    }
    if (state is CommunityPostsPaginationError) {
      botTextToast(
        state.message,
        color: AppColors.primaryColor,
      );
    }
    if (state is CommunityPostDeleted) {
      botTextToast(
        S.of(context).postDeletedSuccessfully,
        color: AppColors.primaryColor,
      );
    }
    if (state is CommunityPostUpdated) {
      botTextToast(
        S.of(context).postUpdatedSuccessfully,
        color: AppColors.primaryColor,
      );
    }

    if (state is CommunityPostReported) {
      botTextToast(
        S.of(context).postReportedSuccessfully,
        color: AppColors.primaryColor,
      );
    }

    if (state is CommunityPostsPaginationLoading) {
      isLoading = true;
    } else {
      isLoading = false;
    }
  }

  Future<void> _handleDeletePost(int index) async {
    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) => DeleteConfirmationDialog(
        content: S.of(context).areYouSureYouWantToDeleteThisPost,
        onConfirm: () async {
          await context.read<CommunityCubit>().deletePost(
                context.read<CommunityCubit>().listOfPosts[index].id,
              );
        },
      ),
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        0.85 * _scrollController.position.maxScrollExtent) {
      if (!isLoading) {
        context.read<CommunityCubit>().getPosts(pageNumber: _currentPage++);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
