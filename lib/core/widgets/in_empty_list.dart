import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';

class InEmptyList extends StatelessWidget {
  const InEmptyList({
    super.key,
    required this.title,
    this.onPressed,
    this.icon = IconlyBroken.tick_square,
    this.image,
  });
  final String title;
  final VoidCallback? onPressed;
  final IconData icon;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 300 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image != null
                ? SvgPicture.asset(
                    image!,
                  )
                : CircleAvatar(
                    radius: context.setMinSize(60),
                    backgroundColor: const Color(0xffF3F4F6),
                    child: IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        icon,
                        color: AppColors.primaryColor,
                        size: 60,
                      ),
                    ),
                  ),
            const VerticalSpacer(16),
            Text(
              title,
              style: AppTextStyle.font18SemiBoldDarkGray(context).copyWith(
                color: const Color(0xff6B7280),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
