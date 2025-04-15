import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ReminderScheduleInfo extends StatelessWidget {
  const ReminderScheduleInfo({
    super.key,
    required this.alarmTime,
    required this.frequency,
  });

  final String alarmTime;
  final String frequency;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              IconlyLight.calendar,
              color: Colors.grey,
            ),
            const HorizontalSpacer(8),
            Text(
              frequency,
              style: AppTextStyle.font14lightWhite(context).copyWith(
                color: Colors.grey,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              IconlyLight.time_circle,
              color: Colors.grey,
            ),
            const HorizontalSpacer(8),
            Text(
              alarmTime,
              style: AppTextStyle.font14lightWhite(context).copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
