import 'dart:async';

import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/services/local_notifications_service.dart';
import 'package:canc_app/users/patient/reminder/data/models/medication_reminder_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class MedicationNotificationService {
  static const String _channelId = 'medication_reminders';
  static const String _channelName = 'Medication Reminders';
  static const String _channelDescription =
      'Notifications for medication reminders';

  static Future<void> initialize() async {
    // Initialize timezone
    tz.initializeTimeZones();

    // Create a dedicated channel for medication reminders
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    // Register the channel with the system
    await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> scheduleMedicationReminder(
    MedicationReminderModel reminder,
  ) async {
    // Cancel any existing notifications for this reminder
    await cancelMedicationReminder(reminder.id);

    // If the reminder is disabled, don't schedule notifications
    if (!reminder.isEnabled) {
      return;
    }

    // Schedule notifications for each alarm time
    for (int i = 0; i < reminder.alarmTimes.length; i++) {
      final DateTime alarmTime = reminder.alarmTimes[i];

      // Skip if the alarm time is in the past
      if (alarmTime.isBefore(DateTime.now())) {
        continue;
      }

      // Generate a unique ID for this notification
      final String notificationId = '${reminder.id}_$i';

      // Create the notification payload
      final Map<String, dynamic> payload = {
        'reminderId': reminder.id,
        'medicationName': reminder.medicationName,
        'type': reminder.type.toString(),
      };

      var title = isArabic() ? 'تذكير أخذ الدواء' : 'Medication Reminder';
      var body = isArabic()
          ? 'وقت أخذ ${reminder.medicationName} - لا تنسَ، صحتك أولوية وأنت تستحق الأفضل 💪'
          : 'Time to take ${reminder.medicationName} - Don\'t forget, your health matters and you deserve the best 💪';

      await LocalNotificationService.flutterLocalNotificationsPlugin
          .zonedSchedule(
        int.parse(notificationId.substring(0, 8), radix: 16),
        title,
        body,
        tz.TZDateTime.from(alarmTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            channelDescription: _channelDescription,
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            fullScreenIntent: true,
            category: AndroidNotificationCategory.reminder,
            enableLights: true,
            enableVibration: true,
            playSound: true,
            showWhen: true,
            autoCancel: true,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            interruptionLevel: InterruptionLevel.timeSensitive,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: payload.toString(),
      );
    }
  }

  static Future<void> cancelMedicationReminder(
    String reminderId,
  ) async {
    // Get all pending notifications
    final List<PendingNotificationRequest> pendingNotifications =
        await FlutterLocalNotificationsPlugin().pendingNotificationRequests();

    // Cancel notifications for this reminder
    for (final notification in pendingNotifications) {
      if (notification.payload != null &&
          notification.payload!.contains(reminderId)) {
        await FlutterLocalNotificationsPlugin().cancel(notification.id);
      }
    }
  }
}
