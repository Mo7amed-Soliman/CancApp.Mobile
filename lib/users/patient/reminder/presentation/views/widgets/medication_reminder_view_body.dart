import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/core/widgets/app_text_form_field.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/frequency_details_model.dart';
import '../../../data/models/frequency_enum.dart';
import '../../../data/models/medication_reminder_model.dart';
import 'alarm_times_list.dart';
import 'frequency_selector.dart';
import 'medication_type_selector.dart';

class MedicationReminderViewBody extends StatefulWidget {
  const MedicationReminderViewBody({super.key, this.reminder});
  final MedicationReminderModel? reminder;
  @override
  State<MedicationReminderViewBody> createState() =>
      _MedicationReminderViewBodyState();
}

class _MedicationReminderViewBodyState
    extends State<MedicationReminderViewBody> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _medicationNameController;
  late List<DateTime> _alarmTimes;
  late MedicationType _selectedType;
  Frequency? _selectedFrequency;
  late FrequencyDetailsModel _frequencyDetails;
  late bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    _medicationNameController = TextEditingController(
      text: widget.reminder?.medicationName,
    );
    _selectedType = widget.reminder?.type ?? MedicationType.pill;
    _alarmTimes = widget.reminder?.alarmTimes ?? [];
    _selectedFrequency = _getInitialFrequency();
    _frequencyDetails =
        widget.reminder?.frequencyDetails ?? const FrequencyDetailsModel();
    _isEnabled = widget.reminder?.isEnabled ?? true;
  }

  Frequency _getInitialFrequency() {
    if (widget.reminder?.frequency != null) {
      return Frequency.values.firstWhere(
        (f) => f.displayName == widget.reminder!.frequency.displayName,
        orElse: () => Frequency.everyDay,
      );
    }
    return Frequency.everyDay;
  }

  @override
  void dispose() {
    _medicationNameController.dispose();
    super.dispose();
  }

  void _addAlarmTime(DateTime time) {
    setState(() {
      _alarmTimes.add(time);
      _alarmTimes.sort();
    });
  }

  void _deleteAlarmTime(DateTime time) {
    setState(() {
      _alarmTimes.remove(time);
    });
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
                      label: 'Meds Name',
                      labelStyle: AppTextStyle.font18SemiBoldDarkGray(context),
                      hintText: 'Enter medication name',
                      fillColor: Colors.grey[50],
                      filled: true,
                      controller: _medicationNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter medication name';
                        }
                        return null;
                      },
                    ),
                    const VerticalSpacer(20),
                    Text(
                      'Select Shape',
                      style: AppTextStyle.font18SemiBoldDarkGray(context),
                    ),
                    const VerticalSpacer(10),
                    MedicationTypeSelector(
                      selectedType: _selectedType,
                      onTypeSelected: (type) =>
                          setState(() => _selectedType = type),
                    ),
                    const VerticalSpacer(20),
                    Text(
                      'Frequency',
                      style: AppTextStyle.font18SemiBoldDarkGray(context),
                    ),
                    const VerticalSpacer(6),
                    FrequencySelector(
                      selectedFrequency: _selectedFrequency,
                      frequencyDetails: _frequencyDetails,
                      onFrequencySelected: (value) {
                        setState(() => _selectedFrequency = value);
                      },
                      onFrequencyDetailsChanged: (details) {
                        setState(() => _frequencyDetails = details);
                      },
                    ),
                    const VerticalSpacer(6),
                    Text(
                      'Alarm Times',
                      style: AppTextStyle.font18SemiBoldDarkGray(context),
                    ),
                    const VerticalSpacer(6),
                    AlarmTimesList(
                      alarmTimes: _alarmTimes,
                      onTimeAdded: _addAlarmTime,
                      onTimeDeleted: _deleteAlarmTime,
                      isEnabled: _isEnabled,
                      onEnabledChanged: (value) =>
                          setState(() => _isEnabled = value),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const VerticalSpacer(20),
          AppButtonWidget(
            onPressed: _saveMedicationReminder,
            text: 'Save',
          ),
          const VerticalSpacer(20),
        ],
      ),
    );
  }

  void _saveMedicationReminder() {
    if (_formKey.currentState!.validate()) {
      if (_alarmTimes.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please add at least one alarm time'),
          ),
        );
        return;
      }

      final reminder = MedicationReminderModel(
        id: widget.reminder?.id ?? const Uuid().v4(),
        medicationName: _medicationNameController.text,
        type: _selectedType,
        frequency: _selectedFrequency!,
        frequencyDetails: _frequencyDetails,
        alarmTimes: _alarmTimes,
        isEnabled: _isEnabled,
      );
      Navigator.pop(context, reminder);
    }
  }
}
