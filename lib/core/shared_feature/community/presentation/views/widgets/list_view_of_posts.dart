import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/post.dart';
import 'package:flutter/material.dart';

class ListOfPosts extends StatelessWidget {
  const ListOfPosts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: const Color(0xffD9D9D9),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return Post(
              post: posts[index],
            );
          },
        ),
      ),
    );
  }
}
