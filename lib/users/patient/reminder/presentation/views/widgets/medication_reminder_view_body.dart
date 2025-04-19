import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/core/widgets/app_text_form_field.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
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
    _selectedFrequency = widget.reminder?.frequency ?? Frequency.everyDay;
    _frequencyDetails =
        widget.reminder?.frequencyDetails ?? const FrequencyDetailsModel();
    _isEnabled = widget.reminder?.isEnabled ?? true;
  }

  @override
  void dispose() {
    _medicationNameController.dispose();
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
                      label: S.of(context).medicationName,
                      labelStyle: AppTextStyle.font18SemiBoldDarkGray(context),
                      hintText: S.of(context).medicationName,
                      fillColor: Colors.grey[50],
                      filled: true,
                      controller: _medicationNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).pleaseEnterMedicationName;
                        }
                        return null;
                      },
                    ),
                    const VerticalSpacer(20),
                    Text(
                      S.of(context).medicationType,
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
                      S.of(context).frequency,
                      style: AppTextStyle.font18SemiBoldDarkGray(context),
                    ),
                    const VerticalSpacer(6),
                    FrequencySelector(
                      selectedFrequency: _selectedFrequency,
                      frequencyDetails: _frequencyDetails,
                      onFrequencySelected: (frequency) {
                        setState(() => _selectedFrequency = frequency);
                      },
                      onFrequencyDetailsChanged: (details) {
                        setState(() => _frequencyDetails = details);
                      },
                    ),
                    const VerticalSpacer(20),
                    Text(
                      S.of(context).alarmTimes,
                      style: AppTextStyle.font18SemiBoldDarkGray(context),
                    ),
                    const VerticalSpacer(6),
                    AlarmTimesList(
                      alarmTimes: _alarmTimes,
                      onTimeAdded: (time) {
                        setState(() {
                          _alarmTimes.add(time);
                        });
                      },
                      onTimeDeleted: (time) {
                        setState(() {
                          _alarmTimes.remove(time);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const VerticalSpacer(20),
          AppButtonWidget(
            text: S.of(context).save,
            onPressed: _saveMedicationReminder,
          ),
        ],
      ),
    );
  }

  Future<void> _saveMedicationReminder() async {
    /// validate the form
    if (_formKey.currentState?.validate() ?? false) {
      /// if the alarm times are empty
      if (_alarmTimes.isEmpty) {
        botTextToast(S.of(context).pleaseAddAtLeastOneAlarmTime);
        return;
      }

      /// if the frequency is days of week and the days of week are not selected
      if (_selectedFrequency == Frequency.daysOfWeek) {
        if (_frequencyDetails.daysOfWeek == null ||
            _frequencyDetails.daysOfWeek?.isEmpty == true) {
          botTextToast(S.of(context).pleaseSelectDaysOfWeek);
          return;
        }
      }

      /// create the reminder
      final reminder = MedicationReminderModel(
        id: widget.reminder?.id ?? const Uuid().v4(),
        medicationName: _medicationNameController.text,
        type: _selectedType,
        frequency: _selectedFrequency!,
        frequencyDetails: _frequencyDetails,
        alarmTimes: _alarmTimes,
        isEnabled: _isEnabled,
      );

      /// pop the reminder
      Navigator.pop(context, reminder);
    }
  }
}
