import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/custom_post_widget.dart';

class ListOfPosts extends StatelessWidget {
  final List<PostModel> posts;
  final bool hasMorePosts;
  final VoidCallback onLoadMore;
  final Function(String) onLike;
  final Function(String) onDislike;
  final Function(String) onDelete;

  const ListOfPosts({
    super.key,
    required this.posts,
    required this.hasMorePosts,
    required this.onLoadMore,
    required this.onLike,
    required this.onDislike,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length + (hasMorePosts ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == posts.length) {
          return Center(
            child: TextButton(
              onPressed: onLoadMore,
              child: Text(
                'Load More',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }
        final post = posts[index];
        return CustomPostWidget(post: post);
      },
    );
  }
}
