part of 'comment_cubit.dart';

sealed class CommentState {}

// Initial state
final class CommentInitial extends CommentState {}

// Loading state
final class CommentLoading extends CommentState {}

// Success states
final class CommentSuccess extends CommentState {
  final List<CommentModel> comments;
  CommentSuccess(this.comments);
}

// Error states
final class CommentError extends CommentState {
  final String errorMessage;
  CommentError(this.errorMessage);
}

// Comment added state
final class CommentAdded extends CommentState {
  final CommentModel comment;
  CommentAdded(this.comment);
}

// Comment deleted state
final class CommentDeleted extends CommentState {
  final int commentId;
  CommentDeleted(this.commentId);
}

// Comment reported state
final class CommentReported extends CommentState {
  final int commentId;
  CommentReported(this.commentId);
}
