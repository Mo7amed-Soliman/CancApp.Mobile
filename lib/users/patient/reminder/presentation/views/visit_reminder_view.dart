import 'package:flutter/material.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import '../../data/models/visit_reminder_model.dart';

import 'widgets/custom_reminder_app_bar.dart';
import 'widgets/visit_reminder_view_body.dart';

class VisitReminderView extends StatelessWidget {
  final VisitReminderModel? reminder;

  const VisitReminderView({super.key, this.reminder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomReminderAppBar(
        title: reminder == null ? 'Add Visit Reminder' : 'Edit Visit Reminder',
        backgroundColor: AppColors.primaryColor,
      ),
      body: VisitReminderViewBody(
        reminder: reminder,
      ),
    );
  }
}
