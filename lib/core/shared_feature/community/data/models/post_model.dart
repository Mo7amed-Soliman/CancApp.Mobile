import 'comment_model.dart';

class PostModel {
  final String id;
  final String userId;
  final String userName;
  final String? userImage;
  final String content;
  final String? image;
  final DateTime createdAt;
  final int commentCount;
  final int reactionCount;
  final int likesCount;
  final int dislikesCount;
  final bool isLiked;
  final bool isDisliked;
  final List<ReactionModel> reactions;

  PostModel({
    required this.id,
    required this.userId,
    required this.userName,
    this.userImage,
    required this.content,
    this.image,
    required this.createdAt,
    this.commentCount = 0,
    this.reactionCount = 0,
    this.likesCount = 0,
    this.dislikesCount = 0,
    this.isLiked = false,
    this.isDisliked = false,
    this.reactions = const [],
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userImage: json['userImage'] as String?,
      content: json['content'] as String,
      image: json['image'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      commentCount: json['commentCount'] as int? ?? 0,
      reactionCount: json['reactionCount'] as int? ?? 0,
      likesCount: json['likesCount'] as int? ?? 0,
      dislikesCount: json['dislikesCount'] as int? ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
      isDisliked: json['isDisliked'] as bool? ?? false,
      reactions: (json['reactions'] as List<dynamic>?)
              ?.map((e) => ReactionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'content': content,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
      'commentCount': commentCount,
      'reactionCount': reactionCount,
      'likesCount': likesCount,
      'dislikesCount': dislikesCount,
      'isLiked': isLiked,
      'isDisliked': isDisliked,
      'reactions': reactions.map((e) => e.toJson()).toList(),
    };
  }

  PostModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userImage,
    String? content,
    String? image,
    DateTime? createdAt,
    int? commentCount,
    int? reactionCount,
    int? likesCount,
    int? dislikesCount,
    bool? isLiked,
    bool? isDisliked,
    List<ReactionModel>? reactions,
  }) {
    return PostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      content: content ?? this.content,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      commentCount: commentCount ?? this.commentCount,
      reactionCount: reactionCount ?? this.reactionCount,
      likesCount: likesCount ?? this.likesCount,
      dislikesCount: dislikesCount ?? this.dislikesCount,
      isLiked: isLiked ?? this.isLiked,
      isDisliked: isDisliked ?? this.isDisliked,
      reactions: reactions ?? this.reactions,
    );
  }
}

class ReactionModel {
  final String postId;
  final bool isComment;
  final String? commentId;
  final String userId;

  ReactionModel({
    required this.postId,
    required this.isComment,
    this.commentId,
    required this.userId,
  });

  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    return ReactionModel(
      postId: json['postId'] as String,
      isComment: json['isComment'] as bool,
      commentId: json['commentId'] as String?,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'isComment': isComment,
      'commentId': commentId,
      'userId': userId,
    };
  }
}
