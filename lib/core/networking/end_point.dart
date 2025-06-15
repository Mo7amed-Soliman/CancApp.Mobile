import 'package:flutter_dotenv/flutter_dotenv.dart';

/// EndPoint is a class that contains the endpoints for the API.
class EndPoint {
  static String apiBaseUrl = dotenv.get('API_BASE_URL');
  static const String login = 'auth/login';
  static const String signUp = 'auth/register';
  static const String completeDoctorSignUp =
      'auth/complete-doctor-registration';
  static const String completePharmacySignUp =
      'auth/complete-pharmacy-registration';
  static const String refreshToken = 'auth/refresh';
  static const String confirmEmail = 'auth/confirm-email';
  static const String resendConfirmEmail = 'auth/resend-confirm-email';
  static const String forgotPassword = 'auth/forget-password';
  static const String resetPassword = 'auth/reset-password';
  static const String registerOtpNewPassword =
      'auth/register-otp-for-new-password';
  static const String changePassword = 'User/ChangePassword';
  static const String updateProfile = 'User/EditUserProfile';
  static const String getNearestPharmacies = 'User/pharmacists';
  static const String getAccessRequests = 'RequestAccess/pending-requests';
  static const String acceptAccessRequest = 'RequestAccess/approve-access';
  static const String requestAccess = 'RequestAccess/request';
  static const String getUsers = 'User/GetUsers';
  static const String sendAccess = 'RequestAccess';
  static const String recordsForPatient = 'RequestAccess/records-for-patient';
  static const String getAcceptedPatients = 'RequestAccess/accepted-patients';
  // community
  static const String getPosts = 'post';
  static const String addPost = 'post';
  static const String deletePost = 'post';
  static const String updatePost = 'post';
  static const String getPost = 'post';
  static const String getPostComments = 'Comments';
  static const String addPostComment = 'Comments';
  static const String updatePostComment = 'Comments';
  static const String deletePostComment = 'Comments';
  static const String addReaction = 'Reaction';
  static const String deleteReaction = 'Reaction';
  static const String getReaction = 'Reaction';

  static String chatbotBaseUrl = dotenv.get('CHAT_BOT_BASE_URL');
  static String cancerRiskPredictionUrl =
      dotenv.get('Cancer_Risk_Prediction_URL');

  static const String charbotAsk = '/ask';
}
