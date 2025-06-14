import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class CustomAppBarChat extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarChat({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
  final String title;
  final String subtitle;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(
          isArabic() ? IconlyLight.arrow_right_2 : IconlyLight.arrow_left_2,
          color: Colors.white,
        ),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: context.setMinSize(20),
            backgroundImage: NetworkImage(imagePath),
          ),
          const HorizontalSpacer(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppTextStyle.font16MediumDarkGray(context).copyWith(
                  color: AppColors.offWhite,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
