import 'package:flutter/material.dart';

import 'date_picker_list.dart';
import 'reminder_tabs.dart';
import 'today_date_display.dart';

class ReminderViewBody extends StatefulWidget {
  const ReminderViewBody({super.key});

  @override
  State<ReminderViewBody> createState() => _ReminderViewBodyState();
}

class _ReminderViewBodyState extends State<ReminderViewBody>
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TodayDateDisplay(),
        DateSelectorFromList(
          selectedDate: DateTime.now(),
          onDateSelected: (date) {
            //TODO: Handle date selection
          },
        ),
        const Expanded(
          child: ReminderTabs(),
        ),
      ],
    );
  }
}
