import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository.dart';
import 'package:canc_app/core/shared_feature/community/manager/community_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityCubit extends Cubit<CommunityState> {
  final CommunityRepository repository;
  int _currentPage = 1;
  static const int _pageSize = 10;

  CommunityCubit({required this.repository}) : super(CommunityInitial());

  Future<void> loadPosts() async {
    emit(CommunityLoading());
    _currentPage = 1;
    await Future.delayed(const Duration(seconds: 5));
    final result = await repository.getPosts();
    // result.fold(
    //   (failure) => emit(CommunityError(failure.toString())),
    //   (posts) => emit(CommunityLoaded(
    //     posts: posts,
    //     hasMorePosts: posts.length == _pageSize,
    //   )),
    // );
    emit(CommunityLoaded(
      posts: dummyPosts,
      hasMorePosts: false,
    ));
  }

  Future<void> loadMorePosts() async {
    if (state is! CommunityLoaded) return;

    final currentState = state as CommunityLoaded;
    if (!currentState.hasMorePosts) return;
    debugPrint('loadMorePosts');
    _currentPage++;
    final result =
        await repository.getMorePosts(int.parse(currentState.posts.last.id));
    result.fold(
      (failure) => emit(CommunityError(failure.toString())),
      (newPosts) {
        final updatedPosts = [...currentState.posts, ...newPosts];
        emit(CommunityLoaded(
          posts: updatedPosts,
          hasMorePosts: newPosts.length == _pageSize,
        ));
      },
    );
  }

  Future<void> createPost(String content, String userId,
      {String? image}) async {
    final result = await repository.createPost(content, userId, image: image);
    result.fold(
      (failure) => emit(CommunityError(failure.toString())),
      (_) => loadPosts(),
    );
  }

  Future<void> updatePost(String id, String content, String userId,
      {String? image}) async {
    final result =
        await repository.updatePost(id, content, userId, image: image);
    result.fold(
      (failure) => emit(CommunityError(failure.toString())),
      (_) => loadPosts(),
    );
  }

  Future<void> deletePost(String postId) async {
    final result = await repository.deletePost(postId);
    result.fold(
      (failure) => emit(CommunityError(failure.toString())),
      (_) => loadPosts(),
    );
  }

  Future<void> likePost(String postId) async {
    final result = await repository.likePost(postId);
    result.fold(
      (failure) => emit(CommunityError(failure.toString())),
      (_) => loadPosts(),
    );
  }

  Future<void> dislikePost(String postId) async {
    final result = await repository.dislikePost(postId);
    result.fold(
      (failure) => emit(CommunityError(failure.toString())),
      (_) => loadPosts(),
    );
  }
}

// Initialize with dummy data for testing
final dummyPosts = [
  PostModel(
    id: '1',
    userId: 'user1',
    userName: 'John Doe',
    userImage: 'https://randomuser.me/api/portraits/men/1.jpg',
    content:
        'Just completed my first chemotherapy session. Feeling hopeful and grateful for the support! Just completed my first chemotherapy session. Feeling hopeful and grateful for the support! Just completed my first chemotherapy session. Feeling hopeful and grateful for the support! Just completed my first chemotherapy session. Feeling hopeful and grateful for the support! Just completed my first chemotherapJust completed my first chemotherapy session. Feeling hopeful and grateful for the support! Just completed my first chemotherapy session. Feeling hopeful and grateful for the support! y session. Feeling hopeful and grateful for the support! Just completed my first chemotherapy session. Feeling hopeful and grateful for the support! 💪',
    image: 'https://picsum.photos/800/600?random=1',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    commentCount: 5,
    reactionCount: 12,
    likesCount: 8,
    dislikesCount: 0,
    isLiked: true,
    isDisliked: false,
  ),
  PostModel(
    id: '2',
    userId: 'user2',
    userName: 'Sarah Smith',
    userImage: 'https://randomuser.me/api/portraits/women/2.jpg',
    content:
        'Sharing my journey with breast cancer. Today marks 6 months since my diagnosis. Stay strong everyone! 💕',
    image: 'https://picsum.photos/800/600?random=2',
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    commentCount: 8,
    reactionCount: 15,
    likesCount: 12,
    dislikesCount: 1,
    isLiked: false,
    isDisliked: false,
  ),
  PostModel(
    id: '3',
    userId: 'user3',
    userName: 'Michael Johnson',
    userImage: 'https://randomuser.me/api/portraits/men/3.jpg',
    content:
        'Looking for advice on managing side effects of radiation therapy. Any tips would be appreciated!',
    createdAt: DateTime.now().subtract(const Duration(hours: 8)),
    commentCount: 3,
    reactionCount: 7,
    likesCount: 5,
    dislikesCount: 0,
    isLiked: false,
    isDisliked: false,
  ),
  PostModel(
    id: '4',
    userId: 'user4',
    userName: 'Emily Davis',
    userImage: 'https://randomuser.me/api/portraits/women/4.jpg',
    content:
        'Celebrating one year cancer-free today! 🎉 Thank you to everyone who supported me through this journey.',
    image: 'https://picsum.photos/800/600?random=3',
    createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    commentCount: 15,
    reactionCount: 25,
    likesCount: 20,
    dislikesCount: 0,
    isLiked: true,
    isDisliked: false,
  ),
  PostModel(
    id: '5',
    userId: 'user5',
    userName: 'David Wilson',
    userImage: 'https://randomuser.me/api/portraits/men/5.jpg',
    content:
        'Just started my treatment plan. Feeling a bit nervous but ready to fight this battle. #CancerWarrior',
    createdAt: DateTime.now().subtract(const Duration(hours: 24)),
    commentCount: 6,
    reactionCount: 10,
    likesCount: 7,
    dislikesCount: 0,
    isLiked: false,
    isDisliked: false,
  ),
];
