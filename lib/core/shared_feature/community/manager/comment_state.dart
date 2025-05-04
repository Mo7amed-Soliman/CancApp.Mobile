import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
import 'package:equatable/equatable.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object?> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<CommentModel> comments;

  const CommentLoaded(this.comments);

  @override
  List<Object?> get props => [comments];
}

class CommentError extends CommentState {
  final String message;

  const CommentError(this.message);

  @override
  List<Object?> get props => [message];
}

class CommentAdded extends CommentState {
  final CommentModel comment;

  const CommentAdded(this.comment);

  @override
  List<Object?> get props => [comment];
}

class CommentUpdated extends CommentState {
  final CommentModel comment;

  const CommentUpdated(this.comment);

  @override
  List<Object?> get props => [comment];
}

class CommentDeleted extends CommentState {
  final String commentId;

  const CommentDeleted(this.commentId);

  @override
  List<Object?> get props => [commentId];
}
