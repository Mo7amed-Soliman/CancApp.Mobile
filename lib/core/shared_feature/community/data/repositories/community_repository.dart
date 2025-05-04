import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
import 'package:dartz/dartz.dart';
import 'package:canc_app/core/networking/api_faliure.dart';

abstract class CommunityRepository {
  // Posts
  Future<Either<Failure, List<PostModel>>> getPosts();
  Future<Either<Failure, List<PostModel>>> getMorePosts(int lastPostId);
  Future<Either<Failure, PostModel>> createPost(String content, String userId,
      {String? image});
  Future<Either<Failure, PostModel>> updatePost(
      String id, String content, String userId,
      {String? image});
  Future<Either<Failure, void>> deletePost(String postId);

  // Post Interactions
  Future<Either<Failure, void>> likePost(String postId);
  Future<Either<Failure, void>> dislikePost(String postId);

  // Comments
  Future<Either<Failure, List<CommentModel>>> getComments(String postId);
  Future<Either<Failure, CommentModel>> addComment(
      String postId, String userId, String content);
  Future<Either<Failure, CommentModel>> updateComment(
      String postId, String commentId, String content);
  Future<Either<Failure, void>> deleteComment(String postId, String commentId);

  // Comment Interactions
  Future<Either<Failure, void>> likeComment(String postId, String commentId);
  Future<Either<Failure, void>> dislikeComment(String postId, String commentId);
}
