import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';

import 'widgets/chats_header.dart';
import 'widgets/category_list.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ChatsHeader(),
        VerticalSpacer(16),
        CategoryList(),
        VerticalSpacer(8),
        // Expanded(
        //   child: ChatsList(userType: UsersKey.doctor),
        // ),
      ],
    );
  }
}
