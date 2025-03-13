import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/shared_feature/onboarding/data/models/user_role_model.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserRoleButton extends StatelessWidget {
  final UserRoleModel role;
  final bool isSelected;
  final VoidCallback onTap;

  static const double horizontalPadding = 12;
  static const double verticalPadding = 16;
  static const double iconSpacing = 56;
  static const double textSpacing = 24;
  static const double borderRadius = 10;

  const UserRoleButton({
    super.key,
    required this.role,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSelected
        ? role.color
        : role.color.withValues(
            alpha: 0.15,
          );
    final borderColor = isSelected
        ? role.color
        : role.color.withValues(
            alpha: 0.15,
          );
    final iconColor = isSelected ? Colors.white : role.color;
    final textColor = isSelected ? Colors.white : role.color;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        context.setMinSize(borderRadius),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(
          vertical: context.setWidth(verticalPadding),
          horizontal: context.setWidth(horizontalPadding),
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            const SizedBox(width: iconSpacing),
            SvgPicture.asset(
              role.imagePath,
              width: context.setMinSize(40),
              height: context.setMinSize(40),
              colorFilter: ColorFilter.mode(
                iconColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: textSpacing),
            Text(
              role.title,
              style: AppTextStyle.font20SemiBold(context)
                  .copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
