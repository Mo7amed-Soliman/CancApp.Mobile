import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      foregroundColor: Colors.white,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.darkTeal,
              AppColors.lightTeal,
            ],
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          title,
          style: AppTextStyle.font20MediumWhite(context),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            isArabic() ? IconlyLight.arrow_right_2 : IconlyLight.arrow_left_2,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(95);
}
