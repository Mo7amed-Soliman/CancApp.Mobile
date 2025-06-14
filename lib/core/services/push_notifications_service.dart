import 'package:canc_app/core/helpers/database/secure_cache_helper.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/services/local_notifications_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
    // await messaging.requestPermission();

    await messaging.getToken().then((value) async {
      // save the token in secure storage
      await SecureCacheHelper().saveData(
        key: CacheKeys.fcmToken,
        value: value!,
      );
    });

    // foreground only
    handleForegroundMessage();

    // background only
    handleBackgroundMessage();
  }

  static void handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationService.showBasicNotification(message);
    });
  }

  // this will be called when the app is in background or terminated
  // and the user taps on the notification
  static void handleBackgroundMessage() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      LocalNotificationService.showBasicNotification(message);
    });
  }
}
