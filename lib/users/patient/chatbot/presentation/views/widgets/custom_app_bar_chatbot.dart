import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/app_assets.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBarChatBot extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarChatBot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      title: Row(
        children: [
          Image.asset(
            AppAssets.botAvatar,
            height: context.setMinSize(58),
            width: context.setMinSize(58),
          ),
          Text(
            'Chatbot',
            style: AppTextStyle.font20MediumWhite(context).copyWith(
              fontSize: context.setSp(24),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
