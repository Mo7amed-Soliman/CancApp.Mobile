import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/home/data/models/quick_action_item_model.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/quick_action_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  /// Creates the list of quick action items with localized titles
  List<QuickActionItemModel> _createQuickActionItems(BuildContext context) {
    return [
      QuickActionItemModel(
        title: S.of(context).reminder,
        icon: IconlyBold.time_circle,
        color: const Color(0xFFFF6B6B),
      ),
      QuickActionItemModel(
        title: S.of(context).record,
        icon: IconlyBold.document,
        color: const Color(0xFF00A19A),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final quickActionItems = _createQuickActionItems(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: context.setHeight(10),
        crossAxisSpacing: context.setWidth(10),
      ),
      itemCount: quickActionItems.length,
      itemBuilder: (context, index) {
        return QuickActionItem(
          item: quickActionItems[index],
          onTap: () {
            /// Navigate to quick action screen
            switch (index) {
              case 0:
                context.push(Routes.reminderView);
              case 1:
              // context.pushNamed(AppRoutes.record);
            }
          },
        );
      },
    );
  }
}
