import 'package:canc_app/core/helpers/class/month_helper.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class TodayDateDisplay extends StatelessWidget {
  const TodayDateDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setMinSize(20),
        vertical: context.setMinSize(10),
      ),
      child: Text(
        '${S.of(context).today}, ${DateTime.now().day} ${MonthHelper.getMonthShort(DateTime.now().month)}',
        style: AppTextStyle.font20MediumWhite(context),
      ),
    );
  }
}
