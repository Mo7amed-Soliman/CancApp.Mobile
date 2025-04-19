import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/medication_reminder_model.dart';
import '../../../data/models/visit_reminder_model.dart';
import '../../manger/medication_reminder_cubit/medication_reminder_cubit.dart';
import '../../manger/visit_reminder_cubit/visit_reminder_cubit.dart';
import '../../../../../../core/widgets/delete_confirmation_dialog.dart';
import 'medications_list.dart';
import 'visits_list.dart';

class ReminderTabs extends StatefulWidget {
  final DateTime selectedDate;

  const ReminderTabs({
    super.key,
    required this.selectedDate,
  });

  @override
  State<ReminderTabs> createState() => _ReminderTabsState();
}

class _ReminderTabsState extends State<ReminderTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.offWhite,
      child: Column(
        children: [
          Container(
            color: AppColors.primaryColor,
            child: TabBar(
              controller: _tabController,
              labelStyle: AppTextStyle.font17Medium(context),
              unselectedLabelStyle: AppTextStyle.font17Medium(context),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: AppColors.offWhite,
              labelColor: AppColors.offWhite,
              unselectedLabelColor: AppColors.offWhite.withValues(alpha: 0.75),
              tabs: [
                Tab(text: S.of(context).medications),
                Tab(text: S.of(context).visits),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                MedicationsList(
                  selectedDate: widget.selectedDate,
                  onEdit: _onEditMedication,
                  onDelete: _onDeleteMedicationConfirmation,
                ),
                VisitsList(
                  selectedDate: widget.selectedDate,
                  onEdit: _onEditVisit,
                  onDelete: _onDeleteVisitConfirmation,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onEditVisit(
    BuildContext context,
    VisitReminderModel reminder,
  ) async {
    final updatedReminder = await context.push<VisitReminderModel>(
      Routes.visitReminderView,
      extra: reminder,
    );

    if (updatedReminder != null && context.mounted) {
      context.read<VisitReminderCubit>().updateVisitReminder(updatedReminder);
    }
  }

  Future<void> _onDeleteVisitConfirmation(
    BuildContext context,
    VisitReminderModel reminder,
  ) async {
    await DeleteConfirmationDialog.show(
      context,
      content: S.of(context).deleteVisit,
      onConfirm: () {
        if (context.mounted) {
          context.read<VisitReminderCubit>().deleteVisitReminder(reminder.id);
        }
      },
    );
  }

  Future<void> _onEditMedication(
    BuildContext context,
    MedicationReminderModel reminder,
  ) async {
    final updatedReminder = await context.push<MedicationReminderModel>(
      Routes.medicationReminderView,
      extra: reminder,
    );

    if (updatedReminder != null && context.mounted) {
      context
          .read<MedicationReminderCubit>()
          .updateMedicationReminder(updatedReminder);
    }
  }

  Future<void> _onDeleteMedicationConfirmation(
    BuildContext context,
    MedicationReminderModel reminder,
  ) async {
    await DeleteConfirmationDialog.show(
      context,
      content: S.of(context).deleteMedication,
      onConfirm: () {
        if (context.mounted) {
          context
              .read<MedicationReminderCubit>()
              .deleteMedicationReminder(reminder.id);
        }
      },
    );
  }
}
