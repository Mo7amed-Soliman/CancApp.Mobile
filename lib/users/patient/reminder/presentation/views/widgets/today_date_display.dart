import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class TodayDateDisplay extends StatelessWidget {
  const TodayDateDisplay({super.key});

  String _getMonthShortEn(int month) {
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

  String _getMonthShortAr(int month) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر'
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
        '${S.of(context).today}, ${DateTime.now().day} ${isArabic() ? _getMonthShortAr(DateTime.now().month) : _getMonthShortEn(DateTime.now().month)}',
        style: AppTextStyle.font20MediumWhite(context),
      ),
    );
  }
}
