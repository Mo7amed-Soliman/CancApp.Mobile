import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/widgets/in_empty_list.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:redacted/redacted.dart';

import '../../../data/models/visit_reminder_model.dart';
import '../../manger/visit_reminder_cubit/visit_reminder_cubit.dart';
import '../../manger/visit_reminder_cubit/visit_reminder_state.dart';
import 'animated_list_item.dart';
import 'visit_card.dart';

class VisitsList extends StatelessWidget {
  final DateTime selectedDate;
  final Function(BuildContext, VisitReminderModel) onEdit;
  final Function(BuildContext, VisitReminderModel) onDelete;

  const VisitsList({
    super.key,
    required this.selectedDate,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VisitReminderCubit, VisitReminderState>(
      listener: (context, state) {
        if (state.error != null) {
          botTextToast(state.error!);
        }
      },
      builder: (context, state) {
        /// if the reminders are loading
        if (state.isLoading) {
          // show shimmer effect
          return ListView.builder(
            padding: EdgeInsets.all(context.setMinSize(16)),
            itemCount: 5,
            itemBuilder: (context, index) {
              final reminder = VisitReminderModel(
                id: '1',
                doctorName: 'Dr. John Doe',
                examinationType: 'Physical Examination',
                time: DateTime.now(),
                date: DateTime.now(),
              );
              return VisitCard(
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

        /// Filter visits based on selected date
        final filteredVisits = state.reminders.where((reminder) {
          return reminder.date.year == selectedDate.year &&
              reminder.date.month == selectedDate.month &&
              reminder.date.day == selectedDate.day;
        }).toList();

        /// if the reminders are empty
        if (state.reminders.isEmpty || filteredVisits.isEmpty) {
          return InEmptyList(
            title: state.reminders.isEmpty
                ? S.of(context).noVisits
                : S.of(context).noVisitsForDate,
            icon: IconlyBold.plus,
            onPressed: () async {
              final reminder = await context.push(Routes.visitReminderView);
              if (context.mounted) {
                context
                    .read<VisitReminderCubit>()
                    .addVisitReminder(reminder as VisitReminderModel);
              }
            },
          );
        }

        /// if get the reminders
        return ListView.builder(
          padding: EdgeInsets.all(context.setMinSize(16)),
          itemCount: filteredVisits.length,
          itemBuilder: (context, index) {
            final reminder = filteredVisits[index];
            return AnimatedListItem(
              index: index,
              child: VisitCard(
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
