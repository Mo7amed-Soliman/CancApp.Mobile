import 'package:canc_app/core/helpers/class/date_helper.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/visit_reminder_model.dart';
import '../../manager/visit_reminder_cubit/visit_reminder_cubit.dart';

import 'reminder_actions.dart';
import 'reminder_schedule_info.dart';

class VisitCard extends StatelessWidget {
  final VisitReminderModel reminder;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isLoading;

  const VisitCard({
    super.key,
    required this.reminder,
    required this.onEdit,
    required this.onDelete,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      reminder.doctorName,
                      style:
                          AppTextStyle.font16MediumDarkGray(context).copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (!isLoading) ...[
                      const VerticalSpacer(8),
                      Text(
                        reminder.examinationType,
                        style: AppTextStyle.font14lightWhite(context).copyWith(
                          color: AppColors.grayish,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ],
                ),
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
                          .read<VisitReminderCubit>()
                          .toggleVisitReminder(reminder.id),
                    ),
            ],
          ),
          const VerticalSpacer(8),
          ReminderScheduleInfo(
            alarmTime:
                isLoading ? 'HH:mm a' : DateHelper.formatTime(reminder.time),
            frequency: isLoading
                ? 'dd-MM-yyyy'
                : DateHelper.formatDate(reminder.date, format: 'dd-MM-yyyy'),
          ),
        ],
      ),
    );
  }
}
