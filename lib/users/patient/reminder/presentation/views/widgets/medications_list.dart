import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/widgets/in_empty_list.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/reminder/data/models/frequency_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:redacted/redacted.dart';

import '../../../data/models/frequency_details_model.dart';
import '../../../data/models/medication_reminder_model.dart';
import '../../manger/medication_reminder_cubit/medication_reminder_cubit.dart';
import '../../manger/medication_reminder_cubit/medication_reminder_state.dart';
import 'animated_list_item.dart';
import 'medication_card.dart';

class MedicationsList extends StatelessWidget {
  final DateTime selectedDate;
  final Function(BuildContext, MedicationReminderModel) onEdit;
  final Function(BuildContext, MedicationReminderModel) onDelete;

  const MedicationsList({
    super.key,
    required this.selectedDate,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicationReminderCubit, MedicationReminderState>(
      builder: (context, state) {
        /// if the reminders are loading
        if (state.isLoading) {
          // show shimmer effect
          return ListView.builder(
            padding: EdgeInsets.all(context.setMinSize(16)),
            itemCount: 5,
            itemBuilder: (context, index) {
              final reminder = MedicationReminderModel(
                id: '1',
                medicationName: 'Medication $index',
                type: MedicationType.pill,
                frequency: Frequency.everyDay,
                frequencyDetails: const FrequencyDetailsModel(),
                alarmTimes: [],
              );
              return MedicationCard(
                isLoading: true,
                reminder: reminder,
                onEdit: () => onEdit(context, reminder),
                onDelete: () => onDelete(context, reminder),
              ).redacted(
                context: context,
                redact: state.isLoading,
                configuration: RedactedConfiguration(
                  redactedColor: Colors.grey[350],
                ),
              );
            },
          );
        }

        /// Filter reminders based on selected date
        final filteredReminders = state.reminders.where((reminder) {
          switch (reminder.frequency) {
            case Frequency.everyDay:
              return true;
            case Frequency.daysOfWeek:
              return reminder.frequencyDetails.daysOfWeek?.contains(
                    selectedDate.weekday,
                  ) ??
                  false;
            case Frequency.everyXDays:
              final daysInterval = reminder.frequencyDetails.daysInterval ?? 1;
              final daysSinceStart =
                  selectedDate.difference(DateTime.now()).inDays;
              return daysSinceStart % daysInterval == 0;
          }
        }).toList();

        /// if the reminders are empty
        if (state.reminders.isEmpty || filteredReminders.isEmpty) {
          return InEmptyList(
            title: filteredReminders.isEmpty
                ? S.of(context).noMedicationsForDate
                : S.of(context).noMedications,
            icon: IconlyBold.plus,
            onPressed: () {
              context.push(Routes.medicationReminderView);
            },
          );
        }

        /// if get the reminders
        return ListView.builder(
          padding: EdgeInsets.all(context.setMinSize(16)),
          itemCount: filteredReminders.length,
          itemBuilder: (context, index) {
            final reminder = filteredReminders[index];
            return AnimatedListItem(
              index: index,
              child: MedicationCard(
                reminder: reminder,
                onEdit: () => onEdit(context, reminder),
                onDelete: () => onDelete(context, reminder),
              ),
            );
          },
        );
      },
    );
  }
}
