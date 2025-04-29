import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class NotificationBadge extends StatelessWidget {
  final int count;
  final VoidCallback onTap;

  const NotificationBadge({
    super.key,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: Text(count.toString()),
      offset: const Offset(-2, 1),
      backgroundColor: Colors.red,
      padding: const EdgeInsets.all(1),
      child: InkWell(
        onTap: onTap,
        child: CircleAvatar(
          radius: context.setMinSize(20),
          backgroundColor: AppColors.offWhite.withValues(alpha: 0.2),
          child: Icon(
            IconlyBold.notification,
            color: AppColors.offWhite,
            size: context.setMinSize(25),
          ),
        ),
      ),
    );
  }
}
