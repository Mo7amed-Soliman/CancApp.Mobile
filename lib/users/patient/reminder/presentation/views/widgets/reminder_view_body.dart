import 'package:flutter/material.dart';

import 'date_picker_list.dart';
import 'reminder_tabs.dart';
import 'today_date_display.dart';

class ReminderViewBody extends StatefulWidget {
  const ReminderViewBody({super.key});

  @override
  State<ReminderViewBody> createState() => _ReminderViewBodyState();
}

class _ReminderViewBodyState extends State<ReminderViewBody> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TodayDateDisplay(),
        DateSelectorFromList(
          selectedDate: _selectedDate,
          onDateSelected: (date) {
            // Filter reminders based on selected date
            if (date.day != _selectedDate.day) {
              setState(() {
                _selectedDate = date;
              });
            }
          },
        ),
        Expanded(
          child: ReminderTabs(
            selectedDate: _selectedDate,
          ),
        ),
      ],
    );
  }
}
