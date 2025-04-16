import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/theming/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class DateSelectorFromList extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const DateSelectorFromList({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.setHeight(110),
      padding: EdgeInsets.symmetric(vertical: context.setMinSize(10)),
      child: EasyDateTimeLine(
        locale: isArabic() ? 'ar' : 'en',
        initialDate: selectedDate,
        onDateChange: onDateSelected,
        headerProps: const EasyHeaderProps(
          showHeader: false,
          showSelectedDate: false,
        ),
        dayProps: EasyDayProps(
          height: context.setHeight(85),
          width: context.setWidth(75),
          dayStructure: DayStructure.dayStrDayNum,
          activeDayStyle: _buildDayStyle(
            context,
            textColor: AppColors.darkGray,
            color: AppColors.offWhite,
            isActive: true,
          ),
          inactiveDayStyle: _buildDayStyle(
            context,
            color: AppColors.offWhite,
            borderColor: AppColors.primaryColor,
          ),
          todayStyle: _buildDayStyle(
            context,
            color: AppColors.offWhite,
            borderColor: AppColors.darkGray.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }

  DayStyle _buildDayStyle(
    BuildContext context, {
    required Color color,
    Color? borderColor,
    Color? textColor,
    bool isActive = false,
  }) {
    return DayStyle(
      dayNumStyle: AppTextStyle.font18SemiBoldDarkGray(context).copyWith(
        color: textColor ?? color,
        height: 1.7,
      ),
      dayStrStyle: AppTextStyle.font14RegularDarkGray(context).copyWith(
        fontWeight: FontWeightHelper.semiBold,
        color: textColor ?? color,
        height: 1.7,
      ),
      decoration: BoxDecoration(
        color: isActive ? color : color.withValues(alpha: 0.35),
        border: borderColor != null
            ? Border.all(
                color: borderColor,
                width: 2,
              )
            : null,
        borderRadius: BorderRadius.all(
          Radius.circular(context.setMinSize(15)),
        ),
      ),
    );
  }
}
