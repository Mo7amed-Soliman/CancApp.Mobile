import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'reminder_popup_menu.dart';

class ReminderActions extends StatelessWidget {
  final bool isEnabled;
  final String reminderId;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const ReminderActions({
    super.key,
    required this.isEnabled,
    required this.reminderId,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: isEnabled,
          onChanged: (_) => onToggle(),
          activeColor: AppColors.primaryColor,
        ),
        ReminderPopupMenu(
          onEdit: onEdit,
          onDelete: onDelete,
        ),
      ],
    );
  }
}
