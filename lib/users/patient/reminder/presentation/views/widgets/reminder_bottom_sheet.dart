import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/reminder/data/models/medication_reminder_model.dart';
import 'package:canc_app/users/patient/reminder/data/models/visit_reminder_model.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:go_router/go_router.dart';

class ReminderBottomSheet extends StatefulWidget {
  const ReminderBottomSheet({super.key});

  @override
  State<ReminderBottomSheet> createState() => _ReminderBottomSheetState();
}

class _ReminderBottomSheetState extends State<ReminderBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.setMinSize(20),
        vertical: context.setMinSize(30),
      ),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.setMinSize(30)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.setMinSize(50),
            height: context.setMinSize(4),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const VerticalSpacer(30),
          Builder(builder: (context) {
            return _ReminderOptionButton(
              title: S.of(context).medicationReminder,
              onTap: () async {
                MedicationReminderModel? reminder =
                    await context.push(Routes.medicationReminderView);

                if (context.mounted) {
                  Navigator.pop<MedicationReminderModel>(context, reminder);
                }
              },
            );
          }),
          const VerticalSpacer(16),
          _ReminderOptionButton(
            title: S.of(context).visitReminder,
            onTap: () async {
              VisitReminderModel? reminder =
                  await context.push(Routes.visitReminderView);

              if (context.mounted) {
                Navigator.pop<VisitReminderModel>(context, reminder);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _ReminderOptionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ReminderOptionButton({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: context.setMinSize(18),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.setMinSize(15)),
          border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: 0.2),
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.font16RegularBlack(context).copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
