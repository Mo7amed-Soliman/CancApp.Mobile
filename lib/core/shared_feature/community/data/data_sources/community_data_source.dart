import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';

abstract class CommunityDataSource {
  // Posts
  Future<List<PostModel>> getPosts();
  Future<List<PostModel>> getMorePosts(int pageNumber);
  Future<PostModel> createPost(String content, String userId, {String? image});
  Future<PostModel> updatePost(String id, String content, String userId,
      {String? image});
  Future<void> deletePost(String postId);

  // Post Interactions
  Future<void> likePost(String postId);
  Future<void> dislikePost(String postId);

  // Comments
  Future<List<CommentModel>> getComments(String postId);
  Future<CommentModel> addComment(String postId, String userId, String content);
  Future<CommentModel> updateComment(
      String postId, String commentId, String content);
  Future<void> deleteComment(String postId, String commentId);

  // Comment Interactions
  Future<void> likeComment(String postId, String commentId);
  Future<void> dislikeComment(String postId, String commentId);
}
