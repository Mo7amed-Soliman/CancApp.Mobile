import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/app_assets.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/users/patient/reminder/data/models/frequency_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../data/models/medication_reminder_model.dart';
import '../../manger/medication_reminder_cubit/medication_reminder_cubit.dart';
import 'reminder_actions.dart';
import 'reminder_schedule_info.dart';

class MedicationCard extends StatelessWidget {
  final MedicationReminderModel reminder;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isLoading;

  const MedicationCard({
    super.key,
    required this.reminder,
    required this.onEdit,
    required this.onDelete,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    String imagePath = _getMedicationImagePath();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: EdgeInsets.only(
        bottom: context.setMinSize(16),
      ),
      padding: EdgeInsets.all(
        context.setMinSize(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  isLoading
                      ? Container(
                          width: context.setMinSize(30),
                          height: context.setMinSize(30),
                          color: Colors.grey[300],
                        )
                      : SvgPicture.asset(
                          imagePath,
                          height: context.setMinSize(30),
                        ),
                  const HorizontalSpacer(20),
                  Text(
                    reminder.medicationName,
                    style: AppTextStyle.font16MediumDarkGray(context).copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              isLoading
                  ? Container(
                      width: context.setMinSize(100),
                      height: context.setMinSize(40),
                      color: Colors.grey[300],
                    )
                  : ReminderActions(
                      isEnabled: reminder.isEnabled,
                      reminderId: reminder.id,
                      onEdit: onEdit,
                      onDelete: onDelete,
                      onToggle: () => context
                          .read<MedicationReminderCubit>()
                          .toggleMedicationReminder(reminder.id),
                    ),
            ],
          ),
          const VerticalSpacer(8),
          ReminderScheduleInfo(
            alarmTime: _formatAlarmTimes(),
            frequency: _getFrequency(),
          ),
        ],
      ),
    );
  }

  String _getMedicationImagePath() {
    switch (reminder.type) {
      case MedicationType.pill:
        return AppAssets.pillIcon;
      case MedicationType.injection:
        return AppAssets.injectionIcon;
      case MedicationType.liquid:
        return AppAssets.liquidIcon;
      case MedicationType.radiation:
        return AppAssets.radiationIcon;
    }
  }

  String _formatAlarmTimes() {
    if (reminder.alarmTimes.isEmpty) return 'No alarms set';
    return DateFormat('HH:mm').format(reminder.alarmTimes.first);
  }

  String _getFrequency() {
    switch (reminder.frequency) {
      case Frequency.everyDay:
        return reminder.frequency.displayName;
      case Frequency.daysOfWeek:
        return reminder.frequencyDetails.daysOfWeek
                ?.map((day) => _getDayName(day))
                .join(', ') ??
            '';
      case Frequency.everyXDays:
        return 'Every ${reminder.frequencyDetails.daysInterval} days';
    }
  }

  String _getDayName(int day) {
    switch (day) {
      case 0:
        return 'Sun';
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      default:
        return '';
    }
  }
}
