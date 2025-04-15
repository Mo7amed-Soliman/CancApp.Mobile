import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/generated/l10n.dart';
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
        ),
        BlocProvider(
          create: (_) => VisitReminderCubit(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: CustomReminderAppBar(
          title: S.of(context).reminder,
          icon: IconlyBold.plus,
          onPressed: () => showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => const ReminderBottomSheet(),
          ),
        ),
        body: const ReminderViewBody(),
      ),
    );
  }
}
