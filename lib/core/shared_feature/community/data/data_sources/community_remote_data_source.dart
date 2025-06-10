import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/end_point.dart';
import 'package:canc_app/core/networking/upload_image_to_api.dart';
import 'package:canc_app/core/shared_feature/community/data/data_sources/community_data_source.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
import 'package:image_picker/image_picker.dart';

class CommunityRemoteDataSource implements CommunityDataSource {
  final ApiConsumer apiConsumer;

  CommunityRemoteDataSource({required this.apiConsumer});
  //! Posts methods
  @override
  Future<List<PostModel>> getPosts({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    final response = await apiConsumer.get(
      EndPoint.getPosts,
      queryParameters: {
        'PageNumber': pageNumber,
        'PageSize': pageSize,
      },
    );
    return (response['value']['data'] as List)
        .map((post) => PostModel.fromJson(post))
        .toList();
  }

  @override
  Future<PostModel> getPostById({required int postId}) async {
    final response = await apiConsumer.get('${EndPoint.getPost}/$postId');
    return PostModel.fromJson(response['value']);
  }

  @override
  Future<void> addPost({
    required String content,
    required String userId,
    XFile? image,
  }) async {
    await apiConsumer.post(
      EndPoint.addPost,
      isFromData: true,
      data: {
        'Content': content,
        'UserId': userId,
        if (image != null) 'Image': await uploadImageToAPI(image),
      },
    );
  }

  @override
  Future<void> updatePost({
    required String id,
    required String content,
    required String userId,
    XFile? image,
  }) async {
    await apiConsumer.put(
      EndPoint.updatePost,
      isFromData: true,
      data: {
        'Id': id,
        'Content': content,
        'UserId': userId,
        if (image != null) 'Image': await uploadImageToAPI(image),
      },
    );
  }

  @override
  Future<void> deletePost({required int postId}) async {
    await apiConsumer.delete(
      '${EndPoint.deletePost}/$postId',
    );
  }

  @override
  Future<void> reportPost({required int postId}) async {
    await apiConsumer.post(
      '${EndPoint.getPost}/$postId/report',
    );
  }

  //! Comments methods
  @override
  Future<List<CommentModel>> getCommentsPerPost({
    required int postId,
  }) async {
    final response =
        await apiConsumer.get('${EndPoint.getPostComments}/$postId');
    return (response['value'] as List)
        .map((comment) => CommentModel.fromJson(comment))
        .toList();
  }

  @override
  Future<CommentModel> getCommentById({
    required int postId,
    required int commentId,
  }) async {
    final response = await apiConsumer.get(
      '${EndPoint.getPostComments}/$postId/$commentId',
    );
    return CommentModel.fromJson(response['value']);
  }

  @override
  Future<void> addComment({
    required int postId,
    required String userId,
    required String content,
  }) async {
    await apiConsumer.post(
      EndPoint.addPostComment,
      data: {
        'postId': postId,
        'userId': userId,
        'content': content,
      },
    );
  }

  @override
  Future<void> updateComment({
    required int postId,
    required int commentId,
    required String content,
  }) async {
    await apiConsumer.put(
      EndPoint.updatePostComment,
      data: {
        'commentId': commentId,
        'postId': postId,
        'content': content,
      },
    );
  }

  @override
  Future<void> deleteComment({
    required int postId,
    required int commentId,
  }) async {
    await apiConsumer.delete(
      '${EndPoint.deletePostComment}/$postId/$commentId',
    );
  }

  @override
  Future<void> reportComment({
    required int postId,
    required int commentId,
  }) async {
    await apiConsumer.post(
      '${EndPoint.getPostComments}/report/$postId/$commentId',
    );
  }

  //! Reactions methods
  @override
  Future<void> addReaction({
    required String postId,
    required bool isComment,
    required String commentId,
    required String userId,
  }) async {
    await apiConsumer.post(
      EndPoint.addReaction,
      data: {
        'postId': int.parse(postId),
        'isComment': isComment,
        'commentId': commentId.isEmpty ? null : int.parse(commentId),
        'userId': userId,
      },
    );
  }

  @override
  Future<void> deleteReaction({
    required int postId,
    required bool isComment,
    required int commentId,
    required String userId,
  }) async {
    await apiConsumer.delete(
      EndPoint.deleteReaction,
      data: {
        'postId': postId,
        'isComment': isComment,
        'commentId': commentId,
        'userId': userId,
      },
    );
  }

  @override
  Future<void> getReaction({
    required int postId,
    required int commentId,
  }) async {
    await apiConsumer.get(
      '${EndPoint.getReaction}/$postId/$commentId',
    );
  }
}
