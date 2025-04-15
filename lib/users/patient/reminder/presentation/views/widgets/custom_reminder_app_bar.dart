import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CustomReminderAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  const CustomReminderAppBar({
    super.key,
    required this.title,
    this.icon,
    this.onPressed,
    this.backgroundColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          isArabic() ? IconlyLight.arrow_right_2 : IconlyLight.arrow_left_2,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: AppTextStyle.font20MediumWhite(context),
      ),
      centerTitle: true,
      actions: icon == null
          ? []
          : [
              IconButton(
                icon: Icon(
                  icon,
                ),
                onPressed: onPressed,
              ),
            ],
    );
  }
}
