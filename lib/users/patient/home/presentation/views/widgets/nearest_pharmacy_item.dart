import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/theming/font_weight_helper.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/users/patient/home/data/models/pharmacy_item_model.dart';
import 'package:flutter/material.dart';

class NearestPharmacyItem extends StatelessWidget {
  const NearestPharmacyItem({
    super.key,
    required this.item,
  });

  final PharmacyItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: context.sizeProvider.height * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(
                  item.image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const VerticalSpacer(6),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  item.name,
                  style: AppTextStyle.font14RegularDarkGray(context).copyWith(
                    fontWeight: FontWeightHelper.medium,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
