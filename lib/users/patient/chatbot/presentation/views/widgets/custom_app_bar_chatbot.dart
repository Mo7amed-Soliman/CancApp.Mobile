import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/app_assets.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class CustomAppBarChatBot extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarChatBot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      centerTitle: false,
      title: Row(
        children: [
          Image.asset(
            AppAssets.botAvatar,
            height: context.setMinSize(58),
            width: context.setMinSize(45),
          ),
          Text(
            'Chatbot',
            style: AppTextStyle.font20MediumWhite(context).copyWith(
              fontSize: context.setSp(24),
            ),
          ),
        ],
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
