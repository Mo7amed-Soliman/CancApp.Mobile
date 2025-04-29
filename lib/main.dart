import 'package:canc_app/canc_app.dart';
import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/database/hive_helper.dart';
import 'package:canc_app/core/services/local_notifications_service.dart';
import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/services/visit_notification_service.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/services/medication_notification_service.dart';

void main() async {
  /// Initialize the Flutter framework
  WidgetsFlutterBinding.ensureInitialized();

  /// Set app orientation to portrait mode only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// Initialize environment variables
  await dotenv.load(fileName: '.env');

  /// setup dependency injection
  await initDependencies();

  /// Initialize cache helper
  await getIt<CacheHelper>().init();

  /// Initialize Hive
  await HiveHelper.init();

  /// Initialize User Service to get user data from hive
  await UserCacheHelper.init();

  /// Initialize Local Notification Service
  await LocalNotificationService.init();

  /// Initalize Medication Reminder Notification Service
  await MedicationNotificationService.initialize();

  /// Initialize Visit Reminder Notification Service
  await VisitNotificationService.initialize();

  /// Run the app
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const CancApp(),
    ),
  );
}
