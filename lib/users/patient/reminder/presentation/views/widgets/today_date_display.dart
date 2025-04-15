import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class TodayDateDisplay extends StatelessWidget {
  const TodayDateDisplay({super.key});

  String _getMonthShort(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setMinSize(20),
        vertical: context.setMinSize(10),
      ),
      child: Text(
        'Today, ${DateTime.now().day} ${_getMonthShort(DateTime.now().month)}',
        style: AppTextStyle.font20MediumWhite(context),
      ),
    );
  }
}
