import 'package:canc_app/core/shared_feature/community/data/models/reaction_model.dart';

class PostModel {
  final int id;
  final String name;
  final DateTime time;
  final String content;
  final String userProfilePictureUrl;
  final String? imageUrl;
  final String userId;
  final int commentsCount;
  final int reactionsCount;
  final List<ReactionModel> reactions;

  PostModel({
    required this.id,
    required this.name,
    required this.time,
    required this.content,
    required this.userProfilePictureUrl,
    this.imageUrl,
    required this.userId,
    required this.commentsCount,
    required this.reactionsCount,
    required this.reactions,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      name: json['name'],
      time: DateTime.parse(json['time']),
      content: json['content'],
      userProfilePictureUrl: json['userProgilePictureUrl'],
      imageUrl: json['imageUrl'],
      userId: json['userId'],
      commentsCount: json['commentsCount'],
      reactionsCount: json['reactionsCount'],
      reactions: (json['reactions'] as List)
          .map((reaction) => ReactionModel.fromJson(reaction))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time.toIso8601String(),
      'content': content,
      'userProgilePictureUrl': userProfilePictureUrl,
      'imageUrl': imageUrl,
      'userId': userId,
      'commentsCount': commentsCount,
      'reactionsCount': reactionsCount,
      'reactions': reactions.map((reaction) => reaction.toJson()).toList(),
    };
  }
}
