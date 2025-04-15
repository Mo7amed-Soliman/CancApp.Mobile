import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({
    super.key,
    required this.title,
    this.onPressed,
    this.icon = IconlyBroken.tick_square,
  });
  final String title;
  final VoidCallback? onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: context.setMinSize(60),
            backgroundColor: const Color(0xffF3F4F6),
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                color: AppColors.primaryColor,
                size: 60,
              ),
            ),
          ),
          const VerticalSpacer(16),
          Text(
            title,
            style: AppTextStyle.font18SemiBoldDarkGray(context).copyWith(
              color: const Color(0xff6B7280),
            ),
          ),
        ],
      ),
    );
  }
}
