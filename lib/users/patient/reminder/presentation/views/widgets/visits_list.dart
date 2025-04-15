import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:redacted/redacted.dart';

import '../../../data/models/visit_reminder_model.dart';
import '../../manger/visit_reminder_cubit/visit_reminder_cubit.dart';
import '../../manger/visit_reminder_cubit/visit_reminder_state.dart';
import 'visit_card.dart';

class VisitsList extends StatelessWidget {
  final Function(BuildContext, VisitReminderModel) onEdit;
  final Function(BuildContext, VisitReminderModel) onDelete;

  const VisitsList({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitReminderCubit, VisitReminderState>(
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

        /// if the reminders are empty
        if (state.reminders.isEmpty) {
          // 'No visit reminders yet'
          // add a button to add a new visit
          return EmptyList(
            title: 'No visit reminders yet',
            icon: IconlyBold.plus,
            onPressed: () {
              context.push(Routes.visitReminderView);
            },
          );
        }

        /// if get the reminders
        return ListView.builder(
          padding: EdgeInsets.all(context.setMinSize(16)),
          itemCount: state.reminders.length,
          itemBuilder: (context, index) {
            final reminder = state.reminders[index];
            return VisitCard(
              reminder: reminder,
              onEdit: () => onEdit(context, reminder),
              onDelete: () => onDelete(context, reminder),
            );
          },
        );
      },
    );
  }
}
