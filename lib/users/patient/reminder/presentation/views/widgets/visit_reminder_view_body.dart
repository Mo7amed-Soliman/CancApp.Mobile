import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:intl/intl.dart';

import '../../../data/models/visit_reminder_model.dart';
import 'alarm_time_selector.dart';
import 'date_selector.dart';

class VisitReminderViewBody extends StatefulWidget {
  final VisitReminderModel? reminder;

  const VisitReminderViewBody({
    super.key,
    this.reminder,
  });

  @override
  State<VisitReminderViewBody> createState() => _VisitReminderViewBodyState();
}

class _VisitReminderViewBodyState extends State<VisitReminderViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _doctorNameController = TextEditingController();
  final _examinationTypeController = TextEditingController();
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _initializeDateTime();
    _initializeControllers();
  }

  void _initializeDateTime() {
    _selectedDate = widget.reminder?.date ?? DateTime.now();
    _selectedTime = TimeOfDay.fromDateTime(
      widget.reminder?.time ?? DateTime.now(),
    );
  }

  void _initializeControllers() {
    _doctorNameController.text = widget.reminder?.doctorName ?? '';
    _examinationTypeController.text = widget.reminder?.examinationType ?? '';
  }

  @override
  void dispose() {
    _doctorNameController.dispose();
    _examinationTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextFormField(
                      label: 'Doctor Name',
                      labelStyle: AppTextStyle.font18SemiBoldDarkGray(context),
                      hintText: 'Enter Doctor Name',
                      fillColor: Colors.grey[50],
                      filled: true,
                      controller: _doctorNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter doctor name';
                        }
                        return null;
                      },
                    ),
                    const VerticalSpacer(20),
                    AppTextFormField(
                      label: 'Examination Type',
                      labelStyle: AppTextStyle.font18SemiBoldDarkGray(context),
                      hintText: 'Enter Examination Type',
                      fillColor: Colors.grey[50],
                      filled: true,
                      controller: _examinationTypeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter examination type';
                        }
                        return null;
                      },
                    ),
                    const VerticalSpacer(20),
                    Text(
                      'Date',
                      style: AppTextStyle.font18SemiBoldDarkGray(context),
                    ),
                    const VerticalSpacer(6),
                    DateSelector(
                      text: DateFormat('dd/MM/yyyy').format(_selectedDate),
                      onTap: () => _selectDate(context),
                    ),
                    const VerticalSpacer(20),
                    Text(
                      'Alarm',
                      style: AppTextStyle.font18SemiBoldDarkGray(context),
                    ),
                    const VerticalSpacer(6),
                    AlarmTimeSelector(
                      selectedTime: _selectedTime,
                      onTimeSelected: _selectTime,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const VerticalSpacer(20),
          AppButtonWidget(
            text: 'Save',
            onPressed: _saveReminder,
          ),
          const VerticalSpacer(20),
        ],
      ),
    );
  }

  void _saveReminder() {
    if (_formKey.currentState!.validate()) {
      final reminder = VisitReminderModel(
        id: widget.reminder?.id,
        doctorName: _doctorNameController.text,
        examinationType: _examinationTypeController.text,
        date: _selectedDate,
        time: _combineDateTime(_selectedDate, _selectedTime),
      );
      // TODO: Save reminder to database
      Navigator.pop(context, reminder);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  DateTime _combineDateTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }
}
