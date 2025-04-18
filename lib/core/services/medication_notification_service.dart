import 'dart:async';

import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/services/local_notifications_service.dart';
import 'package:canc_app/users/patient/reminder/data/models/frequency_enum.dart';
import 'package:canc_app/users/patient/reminder/data/models/medication_reminder_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class MedicationNotificationService {
  static const String _channelId = 'medication_reminders';
  static const String _channelName = 'Medication Reminders';
  static const String _channelDescription =
      'Notifications for medication reminders';
  // initialize the medication notification service and timezone
  static Future<void> initialize() async {
    // Initialize timezone
    tz.initializeTimeZones();

    // Create a dedicated channel for medication reminders
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

  /// schedule a medication reminder based on the reminder frequency
  static Future<void> scheduleMedicationReminder(
    MedicationReminderModel reminder,
  ) async {
    // Cancel any existing notifications for this reminder
    await cancelMedicationReminder(reminder.id);

    // If the reminder is disabled, don't schedule notifications
    if (!reminder.isEnabled) {
      return;
    }

    switch (reminder.frequency) {
      case Frequency.everyDay:
        await _scheduleDailyReminders(reminder);
        break;
      case Frequency.daysOfWeek:
        await _scheduleWeeklyReminders(reminder);
        break;
      case Frequency.everyXDays:
        await _scheduleIntervalReminders(reminder);
        break;
    }
  }

  /// cancel a medication reminder
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

  /// schedule daily reminders
  static Future<void> _scheduleDailyReminders(
    MedicationReminderModel reminder,
  ) async {
    for (int i = 0; i < reminder.alarmTimes.length; i++) {
      final DateTime alarmTime = reminder.alarmTimes[i];
      final String notificationId = '${reminder.id}_daily_$i';

      // check if the alarm date is before today (is in the past)
      if (_isAlarmDateInPast(alarmTime)) {
        continue;
      }

      await _scheduleNotification(
        reminder,
        alarmTime,
        notificationId,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  /// schedule weekly reminders
  static Future<void> _scheduleWeeklyReminders(
    MedicationReminderModel reminder,
  ) async {
    if (reminder.frequencyDetails.daysOfWeek == null) {
      throw ArgumentError(
        'daysOfWeek must be specified for Frequency.daysOfWeek',
      );
    }

    for (int i = 0; i < reminder.alarmTimes.length; i++) {
      final DateTime alarmTime = reminder.alarmTimes[i];

      for (final dayIndex in reminder.frequencyDetails.daysOfWeek!) {
        final String notificationId = '${reminder.id}_weekly_${dayIndex}_$i';

        // Calculate the next occurrence of this weekday
        final tz.TZDateTime scheduledDate = _nextInstanceOfWeekdayTime(
          dayIndex,
          alarmTime.hour,
          alarmTime.minute,
        );

        await _scheduleNotification(
          reminder,
          scheduledDate,
          notificationId,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );
      }
    }
  }

  /// schedule interval reminders
  static Future<void> _scheduleIntervalReminders(
    MedicationReminderModel reminder,
  ) async {
    if (reminder.frequencyDetails.daysInterval == null) {
      throw ArgumentError(
        'daysInterval must be specified for Frequency.everyXDays',
      );
    }

    final interval = reminder.frequencyDetails.daysInterval!;
    final now = DateTime.now();

    // Schedule for the next 30 occurrences
    for (int i = 0; i < 30; i++) {
      for (int j = 0; j < reminder.alarmTimes.length; j++) {
        final DateTime alarmTime = reminder.alarmTimes[j];
        final String notificationId = '${reminder.id}_interval_${i}_$j';

        final scheduledDate = DateTime(
          now.year,
          now.month,
          now.day + (i * interval),
          alarmTime.hour,
          alarmTime.minute,
        );

        // Skip if the time has passed
        if (scheduledDate.isBefore(now)) continue;

        await _scheduleNotification(
          reminder,
          scheduledDate,
          notificationId,
        );
      }
    }
  }

  /// schedule a notification
  static Future<void> _scheduleNotification(
    MedicationReminderModel reminder,
    DateTime scheduledTime,
    String notificationId, {
    DateTimeComponents? matchDateTimeComponents,
  }) async {
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
      int.parse(notificationId.hashCode.toString().substring(0, 7)),
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
      matchDateTimeComponents: matchDateTimeComponents,
    );
  }

  /// calculate the next occurrence of a weekday and time
  static tz.TZDateTime _nextInstanceOfWeekdayTime(
    int dayIndex,
    int hour,
    int minute,
  ) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Calculate days until next occurrence of this weekday
    int daysUntilNext = (dayIndex - scheduledDate.weekday) % 7;
    if (daysUntilNext <= 0) daysUntilNext += 7;

    scheduledDate = scheduledDate.add(Duration(days: daysUntilNext));

    // If the time has passed for today, schedule for next week
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    return scheduledDate;
  }

  static bool _isAlarmDateInPast(DateTime alarmTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final alarmDate = DateTime(alarmTime.year, alarmTime.month, alarmTime.day);

    return alarmDate.isBefore(today);
  }
}
