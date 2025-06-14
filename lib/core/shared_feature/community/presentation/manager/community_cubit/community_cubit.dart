import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:image_picker/image_picker.dart';

part 'community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  final CommunityRepository repository;

  CommunityCubit(this.repository) : super(CommunityInitial());
  List<PostModel> listOfPosts = [];
  // POSTS
  Future<void> getPosts({
    int pageNumber = 1,
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      emit(CommunityPostsRefreshLoading());
    } else if (pageNumber == 1) {
      emit(CommunityPostLoading());
    } else {
      emit(CommunityPostsPaginationLoading());
    }
    final result = await repository.getPosts(pageNumber: pageNumber);

    result.fold(
      (failure) {
        if (pageNumber == 1) {
          emit(CommunityPostsError(failure.errorMessage));
        } else {
          emit(CommunityPostsPaginationError(failure.errorMessage));
        }
      },
      (posts) {
        if (isRefresh) {
          listOfPosts.clear();
          listOfPosts.addAll(posts);
          emit(CommunityPostsSuccess(listOfPosts));
        } else {
          listOfPosts.addAll(posts);
          emit(CommunityPostsSuccess(listOfPosts));
        }
      },
    );
  }

  Future<void> getPostById(int postId, int index) async {
    final result = await repository.getPostById(postId: postId);
    result.fold(
      (failure) => emit(CommunityPostsError(failure.errorMessage)),
      (post) {
        listOfPosts[index] = post;
        emit(CommunityPostSuccess(listOfPosts[index]));
      },
    );
  }

  Future<void> addPost({
    required String content,
    required String userId,
    XFile? image,
  }) async {
    final result = await repository.addPost(
      content: content,
      userId: userId,
      image: image,
    );
    result.fold(
      (failure) => emit(CommunityPostsError(failure.errorMessage)),
      (_) => emit(CommunityPostAdded()),
    );
  }

  Future<void> deletePost(int postId) async {
    final result = await repository.deletePost(postId: postId);
    result.fold(
      (failure) => emit(CommunityPostsError(failure.errorMessage)),
      (_) {
        listOfPosts.removeWhere((post) => post.id == postId);
        emit(CommunityPostDeleted(postId));
      },
    );
  }

  Future<void> updatePost({
    required String id,
    required String content,
    required String userId,
    XFile? image,
  }) async {
    final result = await repository.updatePost(
      id: id,
      content: content,
      userId: userId,
      image: image,
    );
    result.fold(
      (failure) => emit(CommunityPostsError(failure.errorMessage)),
      (_) => emit(CommunityPostUpdated()),
    );
  }

  Future<void> reportPost(int postId) async {
    final result = await repository.reportPost(postId: postId);
    result.fold(
      (failure) => emit(CommunityPostsError(failure.errorMessage)),
      (_) => emit(CommunityPostReported(postId)),
    );
  }

  // REACTIONS
  Future<void> addReaction({
    required String postId,
    required bool isComment,
    required String commentId,
    required String userId,
  }) async {
    final result = await repository.addReaction(
      postId: postId,
      isComment: isComment,
      commentId: commentId,
      userId: userId,
    );
    result.fold(
      (failure) => emit(CommunityReactionsError(failure.errorMessage)),
      (_) => emit(CommunityReactionAdded()),
    );
  }

  Future<void> deleteReaction({
    required int postId,
    required bool isComment,
    required int commentId,
    required String userId,
  }) async {
    final result = await repository.deleteReaction(
      postId: postId,
      isComment: isComment,
      commentId: commentId,
      userId: userId,
    );
    result.fold(
      (failure) => emit(CommunityReactionsError(failure.errorMessage)),
      (_) => emit(CommunityReactionDeleted()),
    );
  }
}
