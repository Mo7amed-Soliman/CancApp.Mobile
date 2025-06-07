part of 'community_cubit.dart';

abstract class CommunityState {}

class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunityPaginationLoading extends CommunityState {}

class CommunityPaginationError extends CommunityState {
  final String message;
  CommunityPaginationError(this.message);
}

class CommunityError extends CommunityState {
  final String message;
  CommunityError(this.message);
}

// Post states
class CommunityPostAdded extends CommunityState {}

class CommunityPostDeleted extends CommunityState {
  final int postId;
  CommunityPostDeleted(this.postId);
}

class CommunityPostUpdated extends CommunityState {}

class CommunityPostReported extends CommunityState {
  final int postId;
  CommunityPostReported(this.postId);
}

class CommunityPostsLoaded extends CommunityState {
  final List<PostModel> posts;
  CommunityPostsLoaded(this.posts);
}

class CommunityPostLoaded extends CommunityState {
  final PostModel post;
  CommunityPostLoaded(this.post);
}

// Comment states
class CommunityCommentAdded extends CommunityState {}

class CommunityCommentDeleted extends CommunityState {
  final int commentId;
  CommunityCommentDeleted(this.commentId);
}

class CommunityCommentUpdated extends CommunityState {}

class CommunityCommentReported extends CommunityState {
  final int commentId;
  CommunityCommentReported(this.commentId);
}

class CommunityCommentsLoaded extends CommunityState {
  final List<CommentModel> comments;
  CommunityCommentsLoaded(this.comments);
}

class CommunityCommentLoaded extends CommunityState {
  final CommentModel comment;
  CommunityCommentLoaded(this.comment);
}

// Reaction states
class CommunityReactionAdded extends CommunityState {}

class CommunityReactionDeleted extends CommunityState {}
