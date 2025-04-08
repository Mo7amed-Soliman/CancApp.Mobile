import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:canc_app/generated/l10n.dart';

class EmptyAccessRequests extends StatelessWidget {
  const EmptyAccessRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: context.setMinSize(65),
            backgroundColor: const Color(0xffF3F4F6),
            child: Icon(
              IconlyBroken.tick_square,
              color: AppColors.primaryColor,
              size: context.setMinSize(65),
            ),
          ),
          const VerticalSpacer(10),
          Text(
            S.of(context).noPendingRequests,
            style: AppTextStyle.font20MediumWhite(context).copyWith(
              color: const Color(0xff6B7280),
            ),
          ),
        ],
      ),
    );
  }
}
