import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatListShimmer extends StatelessWidget {
  const ChatListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.mediumGray.withValues(alpha: 0.3),
          highlightColor: AppColors.mediumGray.withValues(alpha: 0.1),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.setMinSize(16),
              vertical: context.setMinSize(8),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: context.setMinSize(25),
                  backgroundColor: AppColors.mediumGray,
                ),
                const HorizontalSpacer(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: context.screenWidth * 0.4,
                        height: context.setMinSize(16),
                        decoration: BoxDecoration(
                          color: AppColors.mediumGray,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const VerticalSpacer(8),
                      Container(
                        width: context.screenWidth * 0.6,
                        height: context.setMinSize(12),
                        decoration: BoxDecoration(
                          color: AppColors.mediumGray,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
