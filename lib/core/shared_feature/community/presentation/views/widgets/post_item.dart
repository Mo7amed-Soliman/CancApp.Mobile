import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';

import 'post_actions.dart';
import 'post_content.dart';
import 'post_header.dart';
import 'post_image.dart';

class PostItem extends StatefulWidget {
  const PostItem({super.key, required this.post, required this.onDelete});

  final PostModel post;
  final VoidCallback onDelete;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(post: widget.post, onDelete: widget.onDelete),
          PostContent(
            post: widget.post,
            isExpanded: isExpanded,
            onExpand: () => setState(() => isExpanded = !isExpanded),
          ),
          if (widget.post.imageUrl != null)
            PostImage(imageUrl: widget.post.imageUrl!),
          PostActions(post: widget.post),
        ],
      ),
    );
  }
}
