part of 'community_cubit.dart';

abstract class CommunityState {}

class CommunityInitial extends CommunityState {}

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

class CommunityPostsSuccess extends CommunityState {
  final List<PostModel> posts;
  CommunityPostsSuccess(this.posts);
}

class CommunityPostSuccess extends CommunityState {
  final PostModel post;
  CommunityPostSuccess(this.post);
}

class CommunityPostLoading extends CommunityState {}

class CommunityPostsRefreshLoading extends CommunityState {}

class CommunityPostsError extends CommunityState {
  final String message;
  CommunityPostsError(this.message);
}

// Pagination states
class CommunityPostsPaginationLoading extends CommunityState {}

class CommunityPostsPaginationSuccess extends CommunityState {
  final List<PostModel> posts;
  CommunityPostsPaginationSuccess(this.posts);
}

class CommunityPostsPaginationError extends CommunityState {
  final String message;
  CommunityPostsPaginationError(this.message);
}

// Comment states
class CommunityCommentLoading extends CommunityState {}

class CommunityCommentsError extends CommunityState {
  final String message;
  CommunityCommentsError(this.message);
}

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

class CommunityCommentsSuccess extends CommunityState {
  final List<CommentModel> comments;
  CommunityCommentsSuccess(this.comments);
}

class CommunityCommentSuccess extends CommunityState {
  final CommentModel comment;
  CommunityCommentSuccess(this.comment);
}

// Reaction states
class CommunityReactionAdded extends CommunityState {}

class CommunityReactionsError extends CommunityState {
  final String message;
  CommunityReactionsError(this.message);
}

class CommunityReactionDeleted extends CommunityState {}
