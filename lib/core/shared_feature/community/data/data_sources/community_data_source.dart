import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class CommunityDataSource {
  //! Posts methods
  Future<List<PostModel>> getPosts({int pageNumber = 1, int pageSize = 10});

  Future<PostModel> getPostById({required int postId});

  Future<void> addPost({
    required String content,
    required String userId,
    XFile? image,
  });

  Future<void> updatePost({
    required String id,
    required String content,
    required String userId,
    XFile? image,
  });
  Future<void> deletePost({required int postId});

  Future<void> reportPost({required int postId});

  //! Reactions
  Future<void> addReaction({
    required String postId,
    required bool isComment,
    required String commentId,
    required String userId,
  });
  Future<void> deleteReaction({
    required int postId,
    required bool isComment,
    required int commentId,
    required String userId,
  });
  Future<void> getReaction({
    required int postId,
    required int commentId,
  });

  //! Comments methods
  Future<List<CommentModel>> getCommentsPerPost({required int postId});

  Future<CommentModel> getCommentById({
    required int postId,
    required int commentId,
  });

  Future<void> addComment({
    required int postId,
    required String userId,
    required String content,
  });
  Future<void> updateComment({
    required int postId,
    required int commentId,
    required String content,
  });
  Future<void> deleteComment({
    required int postId,
    required int commentId,
  });

  Future<void> reportComment({
    required int postId,
    required int commentId,
  });
}
