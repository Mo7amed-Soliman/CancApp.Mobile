import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/models/otp_model.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/chat/data/models/user_chat_model.dart';
import 'package:canc_app/core/shared_feature/chat/presentation/views/chat_view.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/comment_view.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/create_post_view.dart';
import 'package:canc_app/core/shared_feature/edit_profile/presentation/views/edit_profile_view.dart';
import 'package:canc_app/core/shared_feature/forgot_password/presentation/views/forgot_password_view.dart';
import 'package:canc_app/core/shared_feature/forgot_password/presentation/views/reset_password_view.dart';
import 'package:canc_app/core/shared_feature/otp/presentation/view/otp_view.dart';
import 'package:canc_app/core/shared_feature/login/presentation/views/login_view.dart';
import 'package:canc_app/core/shared_feature/onboarding/presentation/views/language_selection_view.dart';
import 'package:canc_app/core/shared_feature/onboarding/presentation/views/onboarding_view.dart';
import 'package:canc_app/core/shared_feature/sign_up/presentation/views/complete_doctor_registration_view.dart';
import 'package:canc_app/core/shared_feature/sign_up/presentation/views/complete_pharmacy_registration_view.dart';
import 'package:canc_app/core/shared_feature/who/presentation/views/who_are_you.dart';
import 'package:canc_app/core/shared_feature/sign_up/presentation/views/sign_up_view.dart';
import 'package:canc_app/users/doctor/doctor_view.dart';
import 'package:canc_app/users/patient/chat/presentation/views/available_to_chat_view.dart';
import 'package:canc_app/users/patient/chatbot/presentation/views/chatbot_view.dart';
import 'package:canc_app/users/patient/home/data/models/pharmacy_model.dart';
import 'package:canc_app/users/patient/home/presentation/views/access_request_view.dart';
import 'package:canc_app/users/patient/home/presentation/views/nearest_pharmacy_view.dart';
import 'package:canc_app/users/patient/home/presentation/views/patient_bottom_nav_bar.dart';
import 'package:canc_app/users/patient/record/data/models/record_type.dart';
import 'package:canc_app/users/patient/record/presentation/views/record_type_view.dart';
import 'package:canc_app/users/patient/reminder/data/models/medication_reminder_model.dart';
import 'package:canc_app/users/patient/reminder/data/models/visit_reminder_model.dart';
import 'package:canc_app/users/patient/reminder/presentation/views/medication_reminder_view.dart';
import 'package:canc_app/users/patient/reminder/presentation/views/reminder_view.dart';
import 'package:canc_app/users/patient/reminder/presentation/views/visit_reminder_view.dart';
import 'package:canc_app/users/pharmacist/pharmacist_view.dart';
import 'package:canc_app/users/psychiatrist/psychiatrist_view.dart';
import 'package:canc_app/users/volunteer/volunteer_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../users/patient/record/presentation/views/mange_your_records_view.dart';
import '../shared_feature/change_password/presentation/views/change_password.dart';
import '../shared_feature/community/data/models/post_model.dart';

//? GoRouter configuration
final appRouter = GoRouter(
  initialLocation: _getFirstView(),
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: Routes.languageSelectionView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const LanguageSelectionView(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.onBoardingView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const OnBoardingView(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.whoAreYou,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const WhoAreYou(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.loginView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const LoginView(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.signUpView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SignUpView(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.completeDoctorRegistrationView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const CompleteDoctorRegistrationView(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.completePharmacyRegistrationView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const CompletePharmacyRegistrationView(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.forgotPasswordView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ForgotPasswordView(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.otpView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: OTPView(
          otpModel: state.extra as OtpModel,
        ),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.resetPasswordView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: ResetPasswordView(
          email: state.extra as String,
        ),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.homeView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const PatientBottomNavBar(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.accessRequestView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const AccessRequestView(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
        path: Routes.availableToChatView,
        pageBuilder: (context, state) {
          final item = state.extra;

          return CustomTransitionPage(
            key: state.pageKey,
            child: AvailableToChatView(item: item as int?),
            transitionsBuilder: _transitionsBuilder,
          );
        }),
    GoRoute(
      path: Routes.chatView,
      pageBuilder: (context, state) {
        final user = state.extra as UserChatModel;
        return CustomTransitionPage(
          key: state.pageKey,
          child: ChatView(user: user),
          transitionsBuilder: _transitionsBuilder,
        );
      },
    ),
    GoRoute(
      path: Routes.chatBotView,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const ChatBotView(),
          transitionsBuilder: _transitionsBuilder,
        );
      },
    ),
    GoRoute(
      path: Routes.nearestPharmacyView,
      pageBuilder: (context, state) {
        final pharmacies = state.extra as List<Pharmacy>;
        return CustomTransitionPage(
          key: state.pageKey,
          child: NearestPharmacyView(
            pharmacies: pharmacies,
          ),
          transitionsBuilder: _transitionsBuilder,
        );
      },
    ),
    GoRoute(
      path: Routes.reminderView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ReminderView(),
        transitionsBuilder: _transitionsBuilder,
      ),
      routes: [
        GoRoute(
          path: 'medicationReminderView',
          pageBuilder: (context, state) {
            if (state.extra is MedicationReminderModel) {
              final reminder = state.extra as MedicationReminderModel;
              return CustomTransitionPage(
                key: state.pageKey,
                child: MedicationReminderView(
                  reminder: reminder,
                ),
                transitionsBuilder: _transitionsBuilder,
              );
            }
            return CustomTransitionPage(
              key: state.pageKey,
              child: const MedicationReminderView(),
              transitionsBuilder: _transitionsBuilder,
            );
          },
        ),
        GoRoute(
          path: 'visitReminderView',
          pageBuilder: (context, state) {
            if (state.extra is VisitReminderModel) {
              final reminder = state.extra as VisitReminderModel;
              return CustomTransitionPage(
                key: state.pageKey,
                child: VisitReminderView(reminder: reminder),
                transitionsBuilder: _transitionsBuilder,
              );
            }
            return const CustomTransitionPage(
              child: VisitReminderView(),
              transitionsBuilder: _transitionsBuilder,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: Routes.doctorView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const DoctorView(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.volunteerView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const VolunteerView(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.pharmacistView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const PharmacistView(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.psychiatristView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const PsychiatristView(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.commentView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: CommentView(post: state.extra as PostModel),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.createPostView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const CreatePostView(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.changePassword,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ChangePasswordView(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.editProfileView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const EditProfileView(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.manageYourRecordsView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const MangeYourRecordsView(),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.recordTypeView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: RecordTypeView(
          recordType: state.extra as RecordType,
        ),
        transitionsBuilder: _transitionsBuilder,
      ),
    ),
  ],
);

//? slide transition animation helper function
Widget _transitionsBuilder(context, animation, secondaryAnimation, child) {
  final tween = Tween(
    begin: isArabic() ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0),
    end: Offset.zero,
  ).chain(
    CurveTween(curve: Curves.easeInOut),
  );
  final offsetAnimation = animation.drive(tween);
  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}

String _getFirstView() {
  bool? isFirstTime = getIt<CacheHelper>().getData(key: CacheKeys.onBoarding);
  if (isFirstTime == null || !isFirstTime) {
    return Routes.languageSelectionView;
  }
  bool? isLoggedIn = getIt<CacheHelper>().getData(key: CacheKeys.isLoggedIn);
  if (isLoggedIn != null && isLoggedIn) {
    return _getInitialRouteForLoggedInUser() ?? Routes.whoAreYou;
  }
  return Routes.whoAreYou;
}

String? _getInitialRouteForLoggedInUser() {
  final userModel = UserCacheHelper.getUser();
  if (userModel?.userType == UsersKey.patient) {
    return Routes.homeView;
  } else if (userModel?.userType == UsersKey.volunteer) {
    return Routes.volunteerView;
  } else if (userModel?.userType == UsersKey.doctor) {
    return Routes.doctorView;
  } else if (userModel?.userType == UsersKey.pharmacist) {
    return Routes.pharmacistView;
  } else if (userModel?.userType == UsersKey.psychiatrist) {
    return Routes.psychiatristView;
  }
  return null;
}
