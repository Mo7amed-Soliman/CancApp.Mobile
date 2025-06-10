import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  final int id;
  final String content;
  final int postId;
  final DateTime time;
  final String userId;
  final String userImageUrl;
  final String name;
  final int reactionsCount;

  const CommentModel({
    required this.id,
    required this.content,
    required this.postId,
    required this.time,
    required this.userId,
    required this.userImageUrl,
    required this.name,
    required this.reactionsCount,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      content: json['content'],
      postId: json['postId'],
      time: DateTime.parse(json['time']),
      userId: json['userId'],
      userImageUrl: json['userImageUrl'],
      name: json['name'],
      reactionsCount: json['reactionsCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'postId': postId,
      'time': time.toIso8601String(),
      'userId': userId,
      'userImageUrl': userImageUrl,
      'name': name,
      'reactionsCount': reactionsCount,
    };
  }

  @override
  List<Object?> get props => [
        id,
        content,
        postId,
        time,
        userId,
        userImageUrl,
        name,
        reactionsCount,
      ];
}
