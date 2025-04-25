class CommentModel {
  final String userName;
  final String userImageUrl;
  final String commentTime;
  final String content;
  final int likes;
  final String userId;
  final String commentId;
  final String postId;
  final String? replyName;
  final List<CommentModel>? replies;

  CommentModel({
    required this.userName,
    required this.userImageUrl,
    required this.commentTime,
    required this.content,
    required this.likes,
    required this.userId,
    required this.commentId,
    required this.postId,
    this.replyName,
    this.replies,
  });
}

// Sample data for testing
List<CommentModel> dummyComments = [
  CommentModel(
    userName: 'Ahmed Eid',
    userImageUrl: 'assets/images/dummy_image/img3.png',
    commentTime: '5 h',
    content: 'Thank you for sharing this, its so inspiring',
    likes: 3,
    userId: '1',
    commentId: '1',
    postId: '1',
    replies: [
      CommentModel(
        userName: 'Ahmed Ali',
        userImageUrl: 'assets/images/dummy_image/img4.png',
        replyName: 'Ahmed Eid',
        commentTime: '5 h',
        content: 'Thank you brother.',
        likes: 1,
        userId: '2',
        commentId: '2',
        postId: '1',
      ),
    ],
  ),
  CommentModel(
    userName: 'Aliaa shady',
    userImageUrl: 'assets/images/dummy_image/img2.png',
    commentTime: '5 h',
    content:
        'Your strength is inspiring ! wishing you continued courage and positivity on your journey so thank you, I always prayer to you',
    likes: 7,
    userId: '3',
    commentId: '3',
    postId: '1',
  ),
  CommentModel(
    userName: 'Youssef',
    userImageUrl: 'assets/images/dummy_image/img4.png',
    commentTime: '5 h',
    content: 'Thank you for sharing this, its so inspiring',
    likes: 3,
    userId: '4',
    commentId: '4',
    postId: '1',
  ),
];
