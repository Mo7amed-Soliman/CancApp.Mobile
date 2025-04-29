import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/theming/font_weight_helper.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/users/patient/home/data/models/chat_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatCategoryItem extends StatelessWidget {
  const ChatCategoryItem({
    super.key,
    required this.item,
    required this.onTap,
  });
  final ChatItemModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: context.sizeProvider.height * 0.82,
            width: context.setWidth(130),
            padding: EdgeInsets.symmetric(
              horizontal: context.setWidth(40),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: item.color.withValues(alpha: 0.15),
            ),
            child: SvgPicture.asset(
              item.image,
            ),
          ),
        ),
        const VerticalSpacer(4),
        Text(
          item.title,
          style: AppTextStyle.font14RegularDarkGray(context).copyWith(
            fontWeight: FontWeightHelper.medium,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
