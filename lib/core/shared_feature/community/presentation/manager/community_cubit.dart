import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
import 'package:image_picker/image_picker.dart';

part 'community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  final CommunityRepository repository;

  CommunityCubit(this.repository) : super(CommunityInitial());

  // POSTS
  Future<void> getPosts({int pageNumber = 1}) async {
    if (pageNumber == 1) {
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
      (posts) => emit(CommunityPostsSuccess(posts)),
    );
  }

  Future<void> getPostById(int postId) async {
    emit(CommunityPostLoading());
    final result = await repository.getPostById(postId: postId);
    result.fold(
      (failure) => emit(CommunityPostsError(failure.errorMessage)),
      (post) => emit(CommunityPostSuccess(post)),
    );
  }

  Future<void> addPost({
    required String content,
    required String userId,
    XFile? image,
  }) async {
    emit(CommunityPostLoading());
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
    emit(CommunityPostLoading());
    final result = await repository.deletePost(postId: postId);
    result.fold(
      (failure) => emit(CommunityPostsError(failure.errorMessage)),
      (_) => emit(CommunityPostDeleted(postId)),
    );
  }

  Future<void> updatePost({
    required String id,
    required String content,
    required String userId,
    XFile? image,
  }) async {
    emit(CommunityPostLoading());
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
    emit(CommunityPostLoading());
    final result = await repository.reportPost(postId: postId);
    result.fold(
      (failure) => emit(CommunityPostsError(failure.errorMessage)),
      (_) => emit(CommunityPostReported(postId)),
    );
  }

  // COMMENTS
  Future<void> getCommentsPerPost(int postId) async {
    emit(CommunityCommentLoading());
    final result = await repository.getCommentsPerPost(postId: postId);
    result.fold(
      (failure) => emit(CommunityCommentsError(failure.errorMessage)),
      (comments) => emit(CommunityCommentsSuccess(comments)),
    );
  }

  Future<void> getCommentById(
      {required int postId, required int commentId}) async {
    emit(CommunityCommentLoading());
    final result =
        await repository.getCommentById(postId: postId, commentId: commentId);
    result.fold(
      (failure) => emit(CommunityCommentsError(failure.errorMessage)),
      (comment) => emit(CommunityCommentSuccess(comment)),
    );
  }

  Future<void> addComment({
    required int postId,
    required String userId,
    required String content,
  }) async {
    emit(CommunityCommentLoading());
    final result = await repository.addComment(
      postId: postId,
      userId: userId,
      content: content,
    );
    result.fold(
      (failure) => emit(CommunityCommentsError(failure.errorMessage)),
      (_) => emit(CommunityCommentAdded()),
    );
  }

  Future<void> deleteComment({
    required int postId,
    required int commentId,
  }) async {
    emit(CommunityCommentLoading());
    final result = await repository.deleteComment(
      postId: postId,
      commentId: commentId,
    );
    result.fold(
      (failure) => emit(CommunityCommentsError(failure.errorMessage)),
      (_) => emit(CommunityCommentDeleted(commentId)),
    );
  }

  Future<void> updateComment({
    required int postId,
    required int commentId,
    required String content,
  }) async {
    emit(CommunityCommentLoading());
    final result = await repository.updateComment(
      postId: postId,
      commentId: commentId,
      content: content,
    );
    result.fold(
      (failure) => emit(CommunityCommentsError(failure.errorMessage)),
      (_) => emit(CommunityCommentUpdated()),
    );
  }

  Future<void> reportComment({
    required int postId,
    required int commentId,
  }) async {
    emit(CommunityCommentLoading());
    final result = await repository.reportComment(
      postId: postId,
      commentId: commentId,
    );
    result.fold(
      (failure) => emit(CommunityCommentsError(failure.errorMessage)),
      (_) => emit(CommunityCommentReported(commentId)),
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
