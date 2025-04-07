import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/available_to_chat_grid.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/nearest_pharmacy_grid.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/quick_actions_grid.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/section_header.dart';
import 'package:flutter/material.dart';

class MainContent extends StatelessWidget {
  const MainContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chat categories section
            SectionHeader(
              title: S.of(context).chatCategories,
              onSeeAll: () {
                /// Navigate to chat screen
              },
            ),
            // Available to chat section
            const AvailableToChatGrid(),

            // Nearest Pharmacy section
            SectionHeader(
              title: S.of(context).nearestPharmacy,
              onSeeAll: () {
                /// Navigate to pharmacy list screen
              },
            ),
            const NearestPharmacyGrid(),

            // Quick actions section
            SectionHeader(
              title: S.of(context).quickActions,
            ),
            const QuickActionsGrid(),
          ],
        ),
      ),
    );
  }
}
