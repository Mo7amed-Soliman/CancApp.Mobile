import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/theming/font_weight_helper.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/users/patient/home/data/models/quick_action_item_model.dart';
import 'package:flutter/material.dart';

class QuickActionItem extends StatelessWidget {
  const QuickActionItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  final QuickActionItemModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: item.color.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: context.setMinSize(40),
              backgroundColor: item.color,
              child: Icon(
                item.icon,
                color: Colors.white,
                size: context.setMinSize(55),
              ),
            ),
            const VerticalSpacer(10),
            Text(
              item.title,
              style: AppTextStyle.font18SemiBoldDarkGray(context).copyWith(
                fontWeight: FontWeightHelper.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
