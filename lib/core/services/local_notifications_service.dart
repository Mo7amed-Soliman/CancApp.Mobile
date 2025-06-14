import 'dart:async';
import 'dart:convert';

import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();

  static void onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  static Future<void> init() async {
    // Initialize Android notification channel
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialize iOS notification settings
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Initialize settings
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // Initialize the plugin
    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );

    // Request all necessary permissions
    await requestNotificationPermission();
    await requestWakeLockPermission();
  }

  /// Request Notification Permission
  static Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  /// Request Wake Lock Permission for background notifications
  static Future<bool> requestWakeLockPermission() async {
    final status = await Permission.ignoreBatteryOptimizations.request();
    return status.isGranted;
  }

  /// Check Notification Permission
  static Future<bool> checkNotificationPermission() async {
    return await Permission.notification.isGranted;
  }

  //basic Notification
  static void showBasicNotification(RemoteMessage message) async {
    final Response image = await getIt<Dio>().get(
      message.notification?.android?.imageUrl ?? '',
    );
    BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      ByteArrayAndroidBitmap.fromBase64String(
        base64Encode(image.data),
      ),
      largeIcon: ByteArrayAndroidBitmap.fromBase64String(
        base64Encode(image.data),
      ),
    );
    AndroidNotificationDetails android = AndroidNotificationDetails(
      '2002',
      'canc_app_push_notification',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
      playSound: true,
    );
    NotificationDetails details = NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      details,
    );
  }
}
