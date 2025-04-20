import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
  });
  final String title;
  final VoidCallback? onSeeAll;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.setHeight(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.font19MediumDarkGray(context),
            maxLines: 1,
          ),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Row(
                children: [
                  Text(
                    S.of(context).seeAll,
                    style: AppTextStyle.font14RegularDarkGray(context).copyWith(
                      color: AppColors.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                  const HorizontalSpacer(4),
                  Icon(
                    isArabic()
                        ? IconlyLight.arrow_left_2
                        : IconlyLight.arrow_right_2,
                    color: AppColors.primaryColor,
                    size: context.setMinSize(16),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
