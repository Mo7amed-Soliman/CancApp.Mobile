import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';

import 'post_actions.dart';
import 'post_content.dart';
import 'post_header.dart';
import 'post_image.dart';

class Post extends StatefulWidget {
  const Post({super.key, required this.post});

  final PostModel post;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(post: widget.post),
          PostContent(
            post: widget.post,
            isExpanded: isExpanded,
            onExpand: () => setState(() => isExpanded = !isExpanded),
          ),
          if (widget.post.image != null)
            PostImage(imageUrl: widget.post.image!),
          PostActions(post: widget.post),
        ],
      ),
    );
  }
}
