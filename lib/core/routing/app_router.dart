import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/chat/data/models/user_chat_model.dart';
import 'package:canc_app/core/shared_feature/chat/presentation/views/chat_view.dart';
import 'package:canc_app/core/shared_feature/forgot_password/presentation/views/forgot_password_view.dart';
import 'package:canc_app/core/shared_feature/forgot_password/presentation/views/reset_password_view.dart';
import 'package:canc_app/core/shared_feature/otp/presentation/view/otp_view.dart';
import 'package:canc_app/core/shared_feature/login/presentation/views/login_view.dart';
import 'package:canc_app/core/shared_feature/onboarding/presentation/views/language_selection_view.dart';
import 'package:canc_app/core/shared_feature/onboarding/presentation/views/onboarding_view.dart';
import 'package:canc_app/core/shared_feature/who/presentation/views/who_are_you.dart';
import 'package:canc_app/core/shared_feature/sign_up/presentation/views/sign_up_view.dart';
import 'package:canc_app/users/doctor/doctor_view.dart';
import 'package:canc_app/users/patient/chat/presentation/views/available_to_chat_view.dart';
import 'package:canc_app/users/patient/chatbot/presentation/views/chatbot_view.dart';
import 'package:canc_app/users/patient/home/data/models/pharmacy_model.dart';
import 'package:canc_app/users/patient/home/presentation/views/access_request_view.dart';
import 'package:canc_app/users/patient/home/presentation/views/nearest_pharmacy_view.dart';
import 'package:canc_app/users/patient/home/presentation/views/patient_bottom_nav_bar.dart';
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

//? GoRouter configuration
final appRouter = GoRouter(
  initialLocation: Routes.homeView,
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
      path: Routes.resetPasswordView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ResetPasswordView(
          email: 'test@test.com',
        ),
        transitionsBuilder: _transitionsBuilder,
      ),
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
    return _getInitialRouteForLoggedInUser();
  }
  return Routes.whoAreYou;
}

String _getInitialRouteForLoggedInUser() {
  final userModel = UserCacheHelper.getUser();
  if (userModel?.userType == 'Patient') {
    return Routes.homeView;
  } else if (userModel?.userType == 'Volunteer') {
    return Routes.volunteerView;
  } else if (userModel?.userType == 'Doctor') {
    return Routes.doctorView;
  } else if (userModel?.userType == 'Pharmacist') {
    return Routes.pharmacistView;
  } else if (userModel?.userType == 'Psychiatrist') {
    return Routes.psychiatristView;
  }
  return Routes.homeView;
}
