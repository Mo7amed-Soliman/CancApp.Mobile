import 'package:hive_flutter/hive_flutter.dart';
import 'package:canc_app/users/patient/reminder/data/models/medication_reminder_model.dart';
import 'package:canc_app/users/patient/reminder/data/models/visit_reminder_model.dart';
import 'package:canc_app/users/patient/reminder/data/models/frequency_enum.dart';
import 'package:canc_app/users/patient/reminder/data/models/frequency_details_model.dart';
import 'package:canc_app/core/models/user_model.dart';

class HiveHelper {
  //! Boxes
  static const String userBox = 'user';
  static const int userBoxID = 1;
  static const String medicationRemindersBox = 'medication_reminders';
  static const int medicationBoxID = 2;
  static const String frequencyBox = 'frequency';
  static const int frequencyBoxID = 3;
  static const String frequencyDetailsBox = 'frequency_details';
  static const int frequencyDetailsBoxID = 4;
  static const String visitRemindersBox = 'visit_reminders';
  static const int visitBoxID = 5;

  static Future<void> init() async {
    await Hive.initFlutter();

    //! Register adapters
    Hive.registerAdapter<MedicationType>(MedicationTypeAdapter());
    Hive.registerAdapter<MedicationReminderModel>(
        MedicationReminderModelAdapter());
    Hive.registerAdapter<VisitReminderModel>(VisitReminderModelAdapter());
    Hive.registerAdapter<Frequency>(FrequencyAdapter());
    Hive.registerAdapter<FrequencyDetailsModel>(FrequencyDetailsModelAdapter());
    Hive.registerAdapter<UserModel>(UserModelAdapter());
  }
}
