import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/helpers/class/date_helper.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class AlarmTimesList extends StatefulWidget {
  final List<DateTime> alarmTimes;
  final Function(DateTime) onTimeAdded;
  final Function(DateTime) onTimeDeleted;
  final bool isEnabled;
  final Function(bool) onEnabledChanged;

  const AlarmTimesList({
    super.key,
    required this.alarmTimes,
    required this.onTimeAdded,
    required this.onTimeDeleted,
    required this.isEnabled,
    required this.onEnabledChanged,
  });

  @override
  State<AlarmTimesList> createState() => _AlarmTimesListState();
}

class _AlarmTimesListState extends State<AlarmTimesList> {
  TimeOfDay _selectedTime = const TimeOfDay(hour: 8, minute: 0);

  void _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _addTime() {
    final now = DateTime.now();
    final newTime = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    // Check for duplicates (by hour and minute)
    final exists = widget.alarmTimes
        .any((t) => t.hour == newTime.hour && t.minute == newTime.minute);
    if (!exists) {
      widget.onTimeAdded(newTime);
    } else {
      botTextToast(S.of(context).thisTimeIsAlreadyAdded);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _pickTime,
                child: Container(
                  height: 60,
                  alignment:
                      isArabic() ? Alignment.centerRight : Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.paleTealTransparent,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    _selectedTime.format(context),
                    style: AppTextStyle.font14RegularDarkGray(context),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: _addTime,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(80, 55),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                child: Text(
                  S.of(context).add,
                  style: AppTextStyle.font16SemiBoldWhite(context),
                ),
              ),
            ),
          ],
        ),
        const VerticalSpacer(12),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: widget.alarmTimes.isEmpty
              ? const SizedBox.shrink()
              : Wrap(
                  key: ValueKey(widget.alarmTimes.length),
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.alarmTimes.map((time) {
                    return Chip(
                      key: ValueKey(time),
                      label: Text(
                        DateHelper.formatTime(time),
                        style: AppTextStyle.font14RegularDarkGray(context),
                      ),
                      backgroundColor: const Color(0xFFF7F8FA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      deleteIcon:
                          const Icon(Icons.close, size: 18, color: Colors.grey),
                      onDeleted: () => widget.onTimeDeleted(time),
                    );
                  }).toList(),
                ),
        ),
        const VerticalSpacer(16),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.paleTealTransparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            title: Text(
              S.of(context).notification,
              style: AppTextStyle.font14RegularDarkGray(context),
            ),
            trailing: Switch(
              value: widget.isEnabled,
              onChanged: widget.onEnabledChanged,
              activeColor: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
