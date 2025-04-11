import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/theming/font_weight_helper.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class ChatUserCardModel {
  final String name;
  final String address;
  final String imagePath;

  const ChatUserCardModel({
    required this.name,
    required this.address,
    required this.imagePath,
  });
}

class ChatUserCard extends StatelessWidget {
  final ChatUserCardModel model;
  final VoidCallback onChatPressed;

  const ChatUserCard({
    super.key,
    required this.model,
    required this.onChatPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.setMinSize(14),
        horizontal: context.setMinSize(10),
      ),
      margin: EdgeInsets.symmetric(
        vertical: context.setMinSize(6),
        horizontal: context.setMinSize(16),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(context.setMinSize(100)),
            child: Image.asset(
              model.imagePath,
              width: context.setMinSize(64),
              height: context.setMinSize(64),
              fit: BoxFit.cover,
            ),
          ),
          const HorizontalSpacer(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: AppTextStyle.font16MediumDarkGray(context).copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const VerticalSpacer(8),
                Text(
                  model.address,
                  style: AppTextStyle.font12MediumDarkGray(context).copyWith(
                    color: AppColors.grayish,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onChatPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor.withValues(alpha: 0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: context.setMinSize(16),
                vertical: context.setMinSize(12),
              ),
              elevation: 0,
            ),
            child: Text(
              S.of(context).chat,
              style: AppTextStyle.font15Bold(context).copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeightHelper.semiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
