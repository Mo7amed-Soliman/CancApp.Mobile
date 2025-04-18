import 'dart:async';
import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/services/local_notifications_service.dart';
import 'package:canc_app/users/patient/reminder/data/models/visit_reminder_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class VisitNotificationService {
  static const String _channelId = 'visit_reminders';
  static const String _channelName = 'Visit Reminders';
  static const String _channelDescription =
      'Notifications for upcoming doctor visits';

  static Future<void> initialize() async {
    // Initialize timezone
    tz.initializeTimeZones();

    // Create a dedicated channel for visit reminders
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.high,
    );

    // Register the channel with the system
    await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> scheduleVisitReminder(
    VisitReminderModel reminder,
  ) async {
    // Cancel any existing notifications for this reminder
    await cancelVisitReminder(reminder.id);

    // If the reminder is disabled, don't schedule notifications
    if (!reminder.isEnabled) {
      return;
    }

    // Schedule notification for 3 hour before the visit
    final DateTime notificationTime =
        reminder.time.subtract(const Duration(hours: 3));

    // Skip if the notification time is in the past
    if (_isNotificationTimeInPast(notificationTime)) {
      return;
    }

    await _scheduleNotification(
      reminder,
      notificationTime,
      reminder.id,
    );
  }

  static Future<void> cancelVisitReminder(
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

  /// schedule a notification
  static Future<void> _scheduleNotification(VisitReminderModel reminder,
      DateTime scheduledTime, String notificationId) async {
    // Create the notification payload
    final Map<String, dynamic> payload = {
      'reminderId': reminder.id,
      'doctorName': reminder.doctorName,
      'examinationType': reminder.examinationType,
    };

    var title = isArabic() ? 'تذكير موعد الطبيب' : 'Doctor Visit Reminder';
    var body = isArabic()
        ? 'لديك موعد مع ${reminder.doctorName} خلال ساعة - لا تنسَ، صحتك أولوية وأنت تستحق الأفضل 💪'
        : 'You have a visit with ${reminder.doctorName} in 3 hour - Don\'t forget, your health matters and you deserve the best 💪';

    await LocalNotificationService.flutterLocalNotificationsPlugin
        .zonedSchedule(
      reminder.id.hashCode,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          category: AndroidNotificationCategory.reminder,
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

  static bool _isNotificationTimeInPast(DateTime notificationTime) {
    return notificationTime.isBefore(DateTime.now());
  }
}
