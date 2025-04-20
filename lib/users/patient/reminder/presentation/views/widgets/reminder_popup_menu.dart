import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ReminderPopupMenu extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ReminderPopupMenu({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      offset: Offset(0, context.setHeight(35)),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'edit',
          onTap: onEdit,
          child: Row(
            children: [
              const Icon(
                IconlyLight.edit,
                color: AppColors.darkGray,
              ),
              const HorizontalSpacer(12),
              Text(
                S.of(context).edit,
                style: AppTextStyle.font15Bold(context).copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGray,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          onTap: onDelete,
          child: Row(
            children: [
              const Icon(
                IconlyLight.delete,
                color: AppColors.red,
              ),
              const HorizontalSpacer(12),
              Text(
                S.of(context).delete,
                style: AppTextStyle.font15Bold(context).copyWith(
                  color: AppColors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
