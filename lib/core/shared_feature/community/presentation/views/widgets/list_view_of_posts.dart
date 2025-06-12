import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/presentation/manager/community_cubit.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/post_item.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/post_shimmer.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfPosts extends StatefulWidget {
  const ListOfPosts({
    super.key,
  });

  @override
  State<ListOfPosts> createState() => _ListOfPostsState();
}

class _ListOfPostsState extends State<ListOfPosts> {
  late ScrollController _scrollController;
  int _currentPage = 2;
  final List<PostModel> _posts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommunityCubit, CommunityState>(
      listener: (context, state) {
        if (state is CommunityPostsSuccess) {
          _posts.addAll(state.posts);
        }
        if (state is CommunityPostsError) {
          botTextToast(state.message, color: AppColors.red);
        }
        if (state is CommunityPostsPaginationError) {
          botTextToast(state.message, color: AppColors.red);
        }
        if (state is CommunityPostsPaginationLoading) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        if (state is CommunityPostsSuccess ||
            state is CommunityPostsPaginationSuccess ||
            state is CommunityPostsPaginationError ||
            state is CommunityPostsPaginationLoading ||
            state is CommunityPostsRefreshLoading) {
          return Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<CommunityCubit>().getPosts(
                      pageNumber: 1,
                      isRefresh: true,
                    );
                _currentPage = 2;
                _posts.clear();
              },
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverList.builder(
                    itemBuilder: (context, index) {
                      if (index < _posts.length) {
                        return PostItem(
                          post: _posts[index],
                          onDelete: () {
                            context
                                .read<CommunityCubit>()
                                .deletePost(_posts[index].id);
                          },
                        );
                      } else {
                        return const PostShimmer();
                      }
                    },
                    itemCount: _posts.length + (isLoading ? 2 : 0),
                  ),
                ],
              ),
            ),
          );
        } else if (state is CommunityPostsError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => const PostShimmer(),
              itemCount: 5,
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    var currentScrollPosition = _scrollController.position.pixels;
    var maxScrollPosition = _scrollController.position.maxScrollExtent;
    if (currentScrollPosition >= 0.85 * maxScrollPosition) {
      if (!isLoading) {
        context.read<CommunityCubit>().getPosts(pageNumber: _currentPage++);
      }
    }
  }
}
