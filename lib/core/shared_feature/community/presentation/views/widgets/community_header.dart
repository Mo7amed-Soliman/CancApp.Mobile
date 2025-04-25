import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'notification_badge.dart';

class CommunityHeader extends StatelessWidget {
  const CommunityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(
        horizontal: context.setMinSize(16),
      ),
      height: context.screenHeight * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).cancApp,
            style: AppTextStyle.font28RighteousPrimary(context).copyWith(
              color: AppColors.offWhite,
              height: 1.86,
            ),
          ),
          const HorizontalSpacer(10),
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: CircleAvatar(
                  radius: context.setMinSize(20),
                  backgroundColor: AppColors.offWhite.withValues(alpha: 0.2),
                  child: Icon(
                    IconlyBold.plus,
                    color: AppColors.offWhite,
                    size: context.setMinSize(25),
                  ),
                ),
              ),
              const HorizontalSpacer(8),
              NotificationBadge(
                count: 10,
                onTap: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
