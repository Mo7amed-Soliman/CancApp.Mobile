import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
import 'package:dartz/dartz.dart';
import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:image_picker/image_picker.dart';

abstract class CommunityRepository {
  //! Posts methods
  Future<Either<Failure, List<PostModel>>> getPosts({
    int pageNumber = 1,
    int pageSize = 10,
  });
  Future<Either<Failure, PostModel>> getPostById({required int postId});
  Future<Either<Failure, void>> addPost({
    required String content,
    required String userId,
    XFile? image,
  });
  Future<Either<Failure, void>> updatePost({
    required String id,
    required String content,
    required String userId,
    XFile? image,
  });
  Future<Either<Failure, void>> deletePost({required int postId});
  Future<Either<Failure, void>> reportPost({required int postId});

  //! Comments methods
  Future<Either<Failure, List<CommentModel>>> getCommentsPerPost({
    required int postId,
  });
  Future<Either<Failure, CommentModel>> getCommentById({
    required int postId,
    required int commentId,
  });
  Future<Either<Failure, void>> addComment({
    required int postId,
    required String userId,
    required String content,
  });
  Future<Either<Failure, void>> updateComment({
    required int postId,
    required int commentId,
    required String content,
  });
  Future<Either<Failure, void>> deleteComment({
    required int postId,
    required int commentId,
  });
  Future<Either<Failure, void>> reportComment({
    required int postId,
    required int commentId,
  });

  //! Reactions methods
  Future<Either<Failure, void>> addReaction({
    required String postId,
    required bool isComment,
    required String commentId,
    required String userId,
  });
  Future<Either<Failure, void>> deleteReaction({
    required int postId,
    required bool isComment,
    required int commentId,
    required String userId,
  });
  Future<Either<Failure, void>> getReaction({
    required int postId,
    required int commentId,
  });
}
