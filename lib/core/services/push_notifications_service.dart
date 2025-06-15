import 'dart:developer';

import 'package:canc_app/core/helpers/database/secure_cache_helper.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/services/local_notifications_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
    //* fcm token
    await messaging.getToken().then((value) async {
      log('fcm token: $value');
      // save the token in secure storage
      await SecureCacheHelper().saveData(
        key: CacheKeys.fcmToken,
        value: value!,
      );
    });

    //* background and killed
    FirebaseMessaging.onBackgroundMessage(handlebackgroundMessage);

    //* foreground
    handleForegroundMessage();

    //* if the user is logged in
    //* subscribe to topic
    await messaging.subscribeToTopic('all_users');

    //* if the user is logged out
    //* unsubscribe from topic
    //! await messaging.unsubscribeFromTopic('all_users');
  }

  static Future<void> handlebackgroundMessage(RemoteMessage message) async {
    //* show local notification
    LocalNotificationService.showBasicNotification(message);
  }

  static void handleForegroundMessage() {
    //* on message listen for notification when app is in foreground
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        //* show local notification
        LocalNotificationService.showBasicNotification(message);
      },
    );
  }
}
