import 'package:canc_app/canc_app.dart';
import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/class/my_bloc_observer.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/database/hive_helper.dart';
import 'package:canc_app/core/services/local_notifications_service.dart';
import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/services/visit_notification_service.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/services/medication_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:canc_app/firebase_options.dart';

void main() async {
  /// Initialize the Flutter framework
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Set app orientation to portrait mode only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// Initialize environment variables and core services in parallel
  await Future.wait([
    dotenv.load(fileName: '.env'),
    initDependencies(),
    HiveHelper.init(),
  ]);

  /// Initialize cache helper
  await getIt<CacheHelper>().init();

  /// Initialize user data and notification services in parallel
  await Future.wait([
    UserCacheHelper.init(),
    LocalNotificationService.init(),
    MedicationNotificationService.initialize(),
    VisitNotificationService.initialize(),
  ]);
  Bloc.observer = AppBlocObservers();

  /// Run the app
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const CancApp(),
    ),
  );
}
