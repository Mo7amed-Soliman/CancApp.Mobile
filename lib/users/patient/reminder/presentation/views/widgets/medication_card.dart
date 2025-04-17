import 'package:canc_app/core/helpers/class/date_helper.dart';
import 'package:canc_app/core/helpers/class/week_helper.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/app_assets.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/reminder/data/models/frequency_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              Expanded(
                child: Row(
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
                    Expanded(
                      child: Text(
                        reminder.medicationName,
                        style:
                            AppTextStyle.font16MediumDarkGray(context).copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const HorizontalSpacer(16),
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
            alarmTime: _formatAlarmTimes(context),
            frequency: _getFrequency(context),
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

  String _formatAlarmTimes(BuildContext context) {
    // loading state
    if (reminder.alarmTimes.isEmpty) return S.of(context).alarmTimes;
    // if the reminder has only one alarm time
    return DateHelper.formatTime(reminder.alarmTimes.first);
  }

  String _getFrequency(BuildContext context) {
    switch (reminder.frequency) {
      case Frequency.everyDay:
        return reminder.frequency.displayName(context);
      case Frequency.daysOfWeek:
        return reminder.frequencyDetails.daysOfWeek
                ?.map((day) => WeekHelper.getDayName(day))
                .join(', ') ??
            '';
      case Frequency.everyXDays:
        return '${S.of(context).every} ${reminder.frequencyDetails.daysInterval ?? 2} ${S.of(context).days}';
    }
  }
}
