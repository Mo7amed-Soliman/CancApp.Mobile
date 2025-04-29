import 'package:flutter/material.dart';
import 'widgets/community_header.dart';
import 'widgets/list_view_of_posts.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          CommunityHeader(),
          ListOfPosts(),
        ],
      ),
    );
  }
}
