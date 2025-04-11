import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'widgets/available_users_list.dart';
import 'widgets/category_list.dart';
import 'widgets/search_field_availble_to_chat.dart';

class AvailableToChatView extends StatelessWidget {
  const AvailableToChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).chatCategories,
      ),
      body: const Column(
        children: [
          VerticalSpacer(16),
          SearchFieldAvailbleToChat(),
          VerticalSpacer(16),
          CategoryList(),
          VerticalSpacer(16),
          Expanded(
            child: AvailableUsersList(),
          ),
        ],
      ),
    );
  }
}
