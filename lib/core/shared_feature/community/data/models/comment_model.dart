import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  final String id;
  final String content;
  final String userId;
  final String userName;
  final String? userImage;
  final String postId;
  final DateTime createdAt;
  final int likesCount;
  final int dislikesCount;
  final bool isLiked;
  final bool isDisliked;

  const CommentModel({
    required this.id,
    required this.content,
    required this.userId,
    required this.userName,
    this.userImage,
    required this.postId,
    required this.createdAt,
    required this.likesCount,
    required this.dislikesCount,
    required this.isLiked,
    required this.isDisliked,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      content: json['content'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userImage: json['userImage'] as String?,
      postId: json['postId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      likesCount: json['likesCount'] as int,
      dislikesCount: json['dislikesCount'] as int,
      isLiked: json['isLiked'] as bool,
      isDisliked: json['isDisliked'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'postId': postId,
      'createdAt': createdAt.toIso8601String(),
      'likesCount': likesCount,
      'dislikesCount': dislikesCount,
      'isLiked': isLiked,
      'isDisliked': isDisliked,
    };
  }

  @override
  List<Object?> get props => [
        id,
        content,
        userId,
        userName,
        userImage,
        postId,
        createdAt,
        likesCount,
        dislikesCount,
        isLiked,
        isDisliked,
      ];
}
