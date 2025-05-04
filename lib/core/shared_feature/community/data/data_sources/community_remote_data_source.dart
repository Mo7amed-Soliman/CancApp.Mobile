import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/shared_feature/community/data/data_sources/community_data_source.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';

class CommunityRemoteDataSource implements CommunityDataSource {
  final ApiConsumer apiConsumer;

  CommunityRemoteDataSource({required this.apiConsumer});

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await apiConsumer.get('/posts');
    return (response as List).map((post) => PostModel.fromJson(post)).toList();
  }

  @override
  Future<List<PostModel>> getMorePosts(int lastPostId) async {
    final response = await apiConsumer.get('/posts', queryParameters: {
      'lastPostId': lastPostId,
    });
    return (response as List).map((post) => PostModel.fromJson(post)).toList();
  }

  @override
  Future<PostModel> createPost(String content, String userId,
      {String? image}) async {
    final body = {
      'content': content,
      'userId': userId,
      if (image != null) 'image': image,
    };

    final response = await apiConsumer.post(
      'posts',
      data: body,
    );
    return PostModel.fromJson(response);
  }

  @override
  Future<void> deletePost(String postId) async {
    await apiConsumer.delete('/posts/$postId');
  }

  @override
  Future<void> likePost(String postId) async {
    await apiConsumer.post('/posts/$postId/like');
  }

  @override
  Future<void> dislikePost(String postId) async {
    await apiConsumer.post('/posts/$postId/dislike');
  }

  @override
  Future<List<CommentModel>> getComments(String postId) async {
    final response = await apiConsumer.get('/posts/$postId/comments');
    return (response as List)
        .map((comment) => CommentModel.fromJson(comment))
        .toList();
  }

  @override
  Future<CommentModel> addComment(
      String postId, String userId, String content) async {
    final response = await apiConsumer.post(
      'posts/$postId/comments',
      data: {
        'userId': userId,
        'content': content,
      },
    );
    return CommentModel.fromJson(response);
  }

  @override
  Future<CommentModel> updateComment(
      String postId, String commentId, String content) async {
    final response = await apiConsumer.put(
      'posts/$postId/comments/$commentId',
      data: {
        'content': content,
      },
    );
    return CommentModel.fromJson(response);
  }

  @override
  Future<void> deleteComment(String postId, String commentId) async {
    await apiConsumer.delete('/posts/$postId/comments/$commentId');
  }

  @override
  Future<void> likeComment(String postId, String commentId) async {
    await apiConsumer.post('/posts/$postId/comments/$commentId/like');
  }

  @override
  Future<void> dislikeComment(String postId, String commentId) async {
    await apiConsumer.post('/posts/$postId/comments/$commentId/dislike');
  }

  @override
  Future<PostModel> updatePost(String id, String content, String userId,
      {String? image}) async {
    final data = {
      'content': content,
      'userId': userId,
      if (image != null) 'image': image,
    };

    final response = await apiConsumer.put(
      'posts/$id',
      data: data,
    );
    return PostModel.fromJson(response);
  }
}
