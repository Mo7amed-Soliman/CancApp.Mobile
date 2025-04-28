import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class DeliverySwitchSection extends StatelessWidget {
  final bool deliveryEnabled;
  final ValueChanged<bool> onChanged;

  const DeliverySwitchSection({
    super.key,
    required this.deliveryEnabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).deliveryServiceTitle,
          style: AppTextStyle.font16RegularDarkGray(context),
        ),
        const VerticalSpacer(6),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.paleTealTransparent,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).enableDeliveryService,
                      style:
                          AppTextStyle.font14RegularDarkGray(context).copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const VerticalSpacer(4),
                    Text(
                      S.of(context).allowMedicineDelivery,
                      style:
                          AppTextStyle.font12MediumDarkGray(context).copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              Switch(
                value: deliveryEnabled,
                onChanged: onChanged,
                activeColor: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
