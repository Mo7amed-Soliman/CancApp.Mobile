import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/helpers/utils/app_assets.dart';
import 'package:canc_app/users/patient/reminder/data/models/medication_reminder_model.dart';

class MedicationTypeSelector extends StatelessWidget {
  final MedicationType selectedType;
  final Function(MedicationType) onTypeSelected;

  const MedicationTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: MedicationType.values
          .map(
            (type) => Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.setWidth(4)),
                child: TypeOption(
                  type: type,
                  isSelected: type == selectedType,
                  onTypeSelected: onTypeSelected,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class TypeOption extends StatelessWidget {
  final MedicationType type;
  final bool isSelected;
  final Function(MedicationType) onTypeSelected;

  const TypeOption({
    super.key,
    required this.type,
    required this.isSelected,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    String imagePath;
    switch (type) {
      case MedicationType.pill:
        imagePath = AppAssets.pillIcon;
      case MedicationType.injection:
        imagePath = AppAssets.injectionIcon;
      case MedicationType.liquid:
        imagePath = AppAssets.liquidIcon;
      case MedicationType.radiation:
        imagePath = AppAssets.radiationIcon;
    }

    return GestureDetector(
      onTap: () => onTypeSelected(type),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.all(context.setMinSize(16)),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryColor.withValues(alpha: 0.05)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    isSelected ? AppColors.primaryColor : Colors.grey.shade200,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  imagePath,
                  width: context.setMinSize(32),
                  height: context.setMinSize(32),
                ),
              ],
            ),
          ),
          const VerticalSpacer(8),
          Text(
            type.displayName(context),
            style: AppTextStyle.font14RegularDarkGray(context).copyWith(
              color: isSelected ? AppColors.primaryColor : Colors.grey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
