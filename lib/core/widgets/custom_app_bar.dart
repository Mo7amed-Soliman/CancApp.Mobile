import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, required this.title, this.icon, this.onPressed});
  final String title;
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      foregroundColor: Colors.white,
      backgroundColor: AppColors.primaryColor,
      title: Text(
        title,
        style: AppTextStyle.font20MediumWhite(context),
      ),
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(
          isArabic() ? IconlyLight.arrow_right_2 : IconlyLight.arrow_left_2,
          color: Colors.white,
        ),
      ),
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
