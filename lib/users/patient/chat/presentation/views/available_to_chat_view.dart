import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'widgets/available_users_list.dart';
import 'widgets/category_list.dart';
import 'widgets/search_field_availble_to_chat.dart';

class AvailableToChatView extends StatelessWidget {
  const AvailableToChatView({super.key, this.item});
  final int? item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).chatCategories,
      ),
      body: Column(
        children: [
          const VerticalSpacer(16),
          const SearchFieldAvailbleToChat(),
          const VerticalSpacer(16),
          CategoryList(item: item),
          const VerticalSpacer(16),
          const Expanded(
            child: AvailableUsersList(),
          ),
        ],
      ),
    );
  }
}
