import 'package:flutter_dotenv/flutter_dotenv.dart';

/// EndPoint is a class that contains the endpoints for the API.
class EndPoint {
  static String apiBaseUrl = dotenv.get('API_BASE_URL');
  static const String login = 'auth/login';
  static const String signUp = 'auth/register';
  static const String refreshToken = 'auth/refresh';
  static const String confirmEmail = 'auth/confirm-email';
  static const String resendConfirmEmail = 'auth/resend-confirm-email';
  static String getUserDataEndPoint(id) {
    return 'user/get-user/$id';
  }
}
