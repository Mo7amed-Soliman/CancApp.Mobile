import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/reminder/data/models/medication_reminder_model.dart';
import 'package:canc_app/users/patient/reminder/data/models/visit_reminder_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import '../manger/medication_reminder_cubit/medication_reminder_cubit.dart';
import '../manger/visit_reminder_cubit/visit_reminder_cubit.dart';
import 'widgets/reminder_bottom_sheet.dart';
import 'widgets/custom_reminder_app_bar.dart';
import 'widgets/reminder_view_body.dart';

class ReminderView extends StatelessWidget {
  const ReminderView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MedicationReminderCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => VisitReminderCubit(),
          lazy: false,
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.primaryColor,
            appBar: CustomReminderAppBar(
              title: S.of(context).reminder,
              icon: IconlyBold.plus,
              onPressed: () async => await _onAddReminder(context),
            ),
            body: const ReminderViewBody(),
          );
        },
      ),
    );
  }

  Future<void> _onAddReminder(BuildContext context) async {
    var reminder = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const ReminderBottomSheet(),
    );

    if (context.mounted) {
      if (reminder is MedicationReminderModel) {
        await context
            .read<MedicationReminderCubit>()
            .addMedicationReminder(reminder);
      } else if (reminder is VisitReminderModel) {
        await context.read<VisitReminderCubit>().addVisitReminder(reminder);
      }
    }
  }
}
