import 'package:canc_app/core/shared_feature/community/data/data_sources/community_data_source.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:canc_app/core/networking/api_faliure.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityDataSource dataSource;

  CommunityRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<PostModel>>> getPosts() async {
    try {
      final posts = await dataSource.getPosts();
      return Right(posts);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getMorePosts(int lastPostId) async {
    try {
      final posts = await dataSource.getMorePosts(lastPostId);
      return Right(posts);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostModel>> createPost(String content, String userId,
      {String? image}) async {
    try {
      final post = await dataSource.createPost(content, userId, image: image);
      return Right(post);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostModel>> updatePost(
      String id, String content, String userId,
      {String? image}) async {
    try {
      final post =
          await dataSource.updatePost(id, content, userId, image: image);
      return Right(post);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String postId) async {
    try {
      await dataSource.deletePost(postId);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> likePost(String postId) async {
    try {
      await dataSource.likePost(postId);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> dislikePost(String postId) async {
    try {
      await dataSource.dislikePost(postId);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getComments(String postId) async {
    try {
      final comments = await dataSource.getComments(postId);
      return Right(comments);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommentModel>> updateComment(
      String postId, String commentId, String content) async {
    try {
      final comment =
          await dataSource.updateComment(postId, commentId, content);
      return Right(comment);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteComment(
      String postId, String commentId) async {
    try {
      await dataSource.deleteComment(postId, commentId);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> likeComment(
      String postId, String commentId) async {
    try {
      await dataSource.likeComment(postId, commentId);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> dislikeComment(
      String postId, String commentId) async {
    try {
      await dataSource.dislikeComment(postId, commentId);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommentModel>> addComment(
      String postId, String userId, String content) async {
    try {
      final comment = await dataSource.addComment(postId, userId, content);
      return Right(comment);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
