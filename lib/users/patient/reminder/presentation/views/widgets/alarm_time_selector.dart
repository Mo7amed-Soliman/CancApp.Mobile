import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class AlarmTimeSelector extends StatelessWidget {
  final TimeOfDay? selectedTime;
  final Function(BuildContext) onTimeSelected;

  const AlarmTimeSelector({
    super.key,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTimeSelected(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: context.setHeight(18),
          horizontal: context.setWidth(16),
        ),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(context.setWidth(16)),
          border: Border.all(
            color: AppColors.paleTealTransparent,
            width: 2,
          ),
        ),
        child: Text(
          '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')} ${selectedTime!.period == DayPeriod.am ? 'AM' : 'PM'}',
          style: AppTextStyle.font14RegularDarkGray(context),
        ),
      ),
    );
  }
}
