import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
import 'package:canc_app/core/helpers/database/user_cache_helper.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final CommunityRepository _repository;
  List<CommentModel> listOfComments = [];

  CommentCubit(this._repository) : super(CommentInitial());

  List<CommentModel> get comments => listOfComments;

  Future<void> loadComments({required int postId}) async {
    emit(CommentLoading());

    final result = await _repository.getCommentsPerPost(
      postId: postId,
    );

    result.fold(
      (failure) {
        emit(CommentError(failure.errorMessage));
      },
      (comments) {
        listOfComments = comments;
        emit(CommentSuccess(listOfComments));
      },
    );
  }

  Future<void> addComment({
    required int postId,
    required String content,
  }) async {
    final userId = UserCacheHelper.getUser()?.id;
    if (userId == null) {
      emit(CommentError('User not logged in'));
      return;
    }

    final result = await _repository.addComment(
      postId: postId,
      userId: userId,
      content: content,
    );

    result.fold(
      (failure) {
        emit(CommentError(failure.errorMessage));
      },
      (_) {
        listOfComments.add(CommentModel(
          id: DateTime.now().millisecondsSinceEpoch,
          content: content,
          postId: postId,
          time: DateTime.now(),
          userId: userId,
          userImageUrl: UserCacheHelper.getUser()?.image ?? '',
          name: UserCacheHelper.getUser()?.name ?? '',
          reactionsCount: 0,
        ));
        emit(CommentSuccess(listOfComments));
      },
    );
  }

  Future<void> editComment({
    required int postId,
    required int commentId,
    required String content,
  }) async {
    final result = await _repository.updateComment(
      postId: postId,
      commentId: commentId,
      content: content,
    );

    result.fold(
      (failure) {
        emit(CommentError(failure.errorMessage));
      },
      (_) {
        // Update the comment in the local list
        final index = listOfComments.indexWhere((c) => c.id == commentId);
        if (index != -1) {
          final updatedComment = listOfComments[index];
          listOfComments[index] = CommentModel(
            id: updatedComment.id,
            content: content,
            postId: updatedComment.postId,
            time: updatedComment.time,
            userId: updatedComment.userId,
            userImageUrl: updatedComment.userImageUrl,
            name: updatedComment.name,
            reactionsCount: updatedComment.reactionsCount,
          );
          emit(CommentSuccess(listOfComments));
        }
      },
    );
  }

  Future<void> deleteComment({
    required int postId,
    required int commentId,
  }) async {
    final result = await _repository.deleteComment(
      postId: postId,
      commentId: commentId,
    );

    result.fold(
      (failure) {
        emit(CommentError(failure.errorMessage));
      },
      (_) {
        listOfComments.removeWhere((comment) => comment.id == commentId);
        emit(CommentSuccess(listOfComments));
      },
    );
  }

  Future<void> reportComment({
    required int postId,
    required int commentId,
  }) async {
    final result = await _repository.reportComment(
      postId: postId,
      commentId: commentId,
    );

    result.fold(
      (failure) {
        emit(CommentError(failure.errorMessage));
      },
      (_) {
        emit(CommentReported(commentId));
      },
    );
  }

  Future<void> toggleReaction({
    required int postId,
    required int commentId,
    required bool isLiked,
  }) async {
    final userId = UserCacheHelper.getUser()?.id;
    if (userId == null) {
      emit(CommentError('User not logged in'));
      return;
    }

    final result = isLiked
        ? await _repository.addReaction(
            postId: postId.toString(),
            isComment: true,
            commentId: commentId.toString(),
            userId: userId,
          )
        : await _repository.deleteReaction(
            postId: postId,
            isComment: true,
            commentId: commentId,
            userId: userId,
          );

    result.fold(
      (failure) {
        emit(CommentError(failure.errorMessage));
      },
      (_) {
        emit(CommentSuccess(listOfComments));
      },
    );
  }
}
