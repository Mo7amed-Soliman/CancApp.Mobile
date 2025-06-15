import 'dart:async';
import 'dart:convert';

import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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

  //* show basic Notification
  static Future<void> showBasicNotification(RemoteMessage message) async {
    StyleInformation? bigPictureStyleInformation =
        await fetchBigPictureStyleInfo(message);
    AndroidNotificationDetails android = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
    );

    NotificationDetails details = NotificationDetails(
      android: android,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      message.data['title'],
      message.data['body'],
      details,
    );
  }

  static Future<StyleInformation?> fetchBigPictureStyleInfo(
      RemoteMessage message) async {
    BigPictureStyleInformation? bigPictureStyleInformation;

    try {
      final Dio dio = getIt<Dio>();
      //? Make a GET request to the image URL, expecting a byte response
      await dio
          .get(
        message.data['image_url'],
        options: Options(responseType: ResponseType.bytes),
      )
          .then(
        // Process the response data
        (value) {
          //! Convert the byte data to a base64 string, then to a byte array
          //! for use in the BigPictureStyleInformation object

          bigPictureStyleInformation = BigPictureStyleInformation(
            ByteArrayAndroidBitmap.fromBase64String(
              base64Encode(value.data),
            ),
            largeIcon: ByteArrayAndroidBitmap.fromBase64String(
              base64Encode(value.data),
            ),
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }

    return bigPictureStyleInformation;
  }
}
