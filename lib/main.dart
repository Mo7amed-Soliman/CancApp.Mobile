import 'package:canc_app/canc_app.dart';
import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/database/hive_helper.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  /// Initialize the Flutter framework
  WidgetsFlutterBinding.ensureInitialized();

  /// Set app orientation to portrait mode only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// setup dependency injection
  setupGetIt();

  /// Initialize cache helper
  await getIt<CacheHelper>().init();

  /// Initialize Hive
  await HiveHelper.init();

  /// Run the app
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const CancApp(),
    ),
  );
}
