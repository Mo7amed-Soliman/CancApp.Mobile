import 'package:canc_app/core/shared_feature/community/data/data_sources/community_data_source.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:image_picker/image_picker.dart';

import '../models/comment_model.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityDataSource dataSource;

  CommunityRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<PostModel>>> getPosts({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final posts = await dataSource.getPosts(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      return Right(posts);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostModel>> getPostById({required int postId}) async {
    try {
      final post = await dataSource.getPostById(postId: postId);
      return Right(post);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addPost({
    required String content,
    required String userId,
    XFile? image,
  }) async {
    try {
      await dataSource.addPost(
        content: content,
        userId: userId,
        image: image,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePost({
    required String id,
    required String content,
    required String userId,
    XFile? image,
  }) async {
    try {
      await dataSource.updatePost(
        id: id,
        content: content,
        userId: userId,
        image: image,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost({required int postId}) async {
    try {
      await dataSource.deletePost(postId: postId);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> reportPost({required int postId}) async {
    try {
      await dataSource.reportPost(postId: postId);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getCommentsPerPost({
    required int postId,
  }) async {
    try {
      final comments = await dataSource.getCommentsPerPost(postId: postId);
      return Right(comments);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommentModel>> getCommentById({
    required int postId,
    required int commentId,
  }) async {
    try {
      final comment = await dataSource.getCommentById(
        postId: postId,
        commentId: commentId,
      );
      return Right(comment);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addComment({
    required int postId,
    required String userId,
    required String content,
  }) async {
    try {
      await dataSource.addComment(
        postId: postId,
        userId: userId,
        content: content,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateComment({
    required int postId,
    required int commentId,
    required String content,
  }) async {
    try {
      await dataSource.updateComment(
        postId: postId,
        commentId: commentId,
        content: content,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteComment({
    required int postId,
    required int commentId,
  }) async {
    try {
      await dataSource.deleteComment(
        postId: postId,
        commentId: commentId,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> reportComment({
    required int postId,
    required int commentId,
  }) async {
    try {
      await dataSource.reportComment(
        postId: postId,
        commentId: commentId,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addReaction({
    required String postId,
    required bool isComment,
    required String commentId,
    required String userId,
  }) async {
    try {
      await dataSource.addReaction(
        postId: postId,
        isComment: isComment,
        commentId: commentId,
        userId: userId,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteReaction({
    required int postId,
    required bool isComment,
    required int commentId,
    required String userId,
  }) async {
    try {
      await dataSource.deleteReaction(
        postId: postId,
        isComment: isComment,
        commentId: commentId,
        userId: userId,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> getReaction({
    required int postId,
    required int commentId,
  }) async {
    try {
      await dataSource.getReaction(
        postId: postId,
        commentId: commentId,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
