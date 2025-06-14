import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class PostPopupMenu extends StatelessWidget {
  const PostPopupMenu({
    super.key,
    required this.userId,
    required this.onDelete,
    required this.onEdit,
    required this.onReport,
  });

  final String userId;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onReport;

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = UserCacheHelper.getUser()?.id == userId;
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      offset: Offset(0, context.setHeight(32)),
      itemBuilder: (context) => [
        if (isCurrentUser)
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
        if (isCurrentUser)
          PopupMenuItem(
            value: 'delete',
            onTap: onDelete,
            child: Row(
              children: [
                const Icon(
                  IconlyLight.delete,
                  color: AppColors.darkGray,
                ),
                const HorizontalSpacer(12),
                Text(
                  S.of(context).delete,
                  style: AppTextStyle.font15Bold(context).copyWith(
                    color: AppColors.darkGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        if (!isCurrentUser)
          PopupMenuItem(
            value: 'report',
            onTap: onReport,
            child: Row(
              children: [
                const Icon(
                  IconlyLight.info_circle,
                  color: AppColors.red,
                ),
                const HorizontalSpacer(12),
                Text(
                  S.of(context).report,
                  style: AppTextStyle.font15Bold(context).copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkGray,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
