import 'package:canc_app/core/error/failure.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository.dart';
import 'package:canc_app/core/shared_feature/community/manager/comment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentCubit extends Cubit<CommentState> {
  final CommunityRepository repository;
  final String postId;

  CommentCubit({
    required this.repository,
    required this.postId,
  }) : super(CommentInitial()) {
    getComments();
  }

  Future<void> getComments() async {
    emit(CommentLoading());
    final result = await repository.getComments(postId);
    result.fold(
      (failure) => emit(CommentError(failure.toString())),
      (comments) => emit(CommentLoaded(comments)),
    );
  }

  Future<void> addComment(String content, String userId) async {
    emit(CommentLoading());
    final result = await repository.addComment(postId, userId, content);
    result.fold(
      (failure) => emit(CommentError(failure.toString())),
      (comment) {
        emit(CommentAdded(comment));
        getComments(); // Refresh the comments list
      },
    );
  }

  Future<void> updateComment(String commentId, String content) async {
    emit(CommentLoading());
    final result = await repository.updateComment(postId, commentId, content);
    result.fold(
      (failure) => emit(CommentError(failure.toString())),
      (comment) {
        emit(CommentUpdated(comment));
        getComments(); // Refresh the comments list
      },
    );
  }

  Future<void> deleteComment(String commentId) async {
    emit(CommentLoading());
    final result = await repository.deleteComment(postId, commentId);
    result.fold(
      (failure) => emit(CommentError(failure.toString())),
      (_) {
        emit(CommentDeleted(commentId));
        getComments(); // Refresh the comments list
      },
    );
  }

  Future<void> likeComment(String commentId) async {
    final result = await repository.likeComment(postId, commentId);
    result.fold(
      (failure) => emit(CommentError(failure.toString())),
      (_) => getComments(), // Refresh the comments list
    );
  }

  Future<void> dislikeComment(String commentId) async {
    final result = await repository.dislikeComment(postId, commentId);
    result.fold(
      (failure) => emit(CommentError(failure.toString())),
      (_) => getComments(), // Refresh the comments list
    );
  }
}
