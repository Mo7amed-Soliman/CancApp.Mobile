import 'package:flutter/material.dart';
import 'package:canc_app/core/theming/app_colors.dart';

import '../../data/models/medication_reminder_model.dart';
import 'widgets/medication_reminder_view_body.dart';
import 'widgets/custom_reminder_app_bar.dart';

class MedicationReminderView extends StatelessWidget {
  final MedicationReminderModel? reminder;

  const MedicationReminderView({super.key, this.reminder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomReminderAppBar(
        title: reminder == null ? 'Add Meds Reminder' : 'Edit Meds Reminder',
        backgroundColor: AppColors.primaryColor,
      ),
      body: MedicationReminderViewBody(
        reminder: reminder,
      ),
    );
  }
}
