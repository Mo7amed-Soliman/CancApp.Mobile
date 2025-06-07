class ReactionModel {
  final DateTime time;
  final int postId;
  final int? commentId;
  final String userId;
  final String fullName;
  final String userProfilePictureUrl;
  final bool isComment;

  ReactionModel({
    required this.time,
    required this.postId,
    this.commentId,
    required this.userId,
    required this.fullName,
    required this.userProfilePictureUrl,
    required this.isComment,
  });

  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    return ReactionModel(
      time: DateTime.parse(json['time']),
      postId: json['postId'],
      commentId: json['commentId'],
      userId: json['userId'],
      fullName: json['fullName'],
      userProfilePictureUrl: json['userProfilePictureUrl'],
      isComment: json['isComment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time.toIso8601String(),
      'postId': postId,
      'commentId': commentId,
      'userId': userId,
      'fullName': fullName,
      'userProfilePictureUrl': userProfilePictureUrl,
      'isComment': isComment,
    };
  }
}
