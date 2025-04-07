// import 'package:canc_app/core/di/dependency_injection.dart';
// import 'package:canc_app/core/helpers/database/cache_helper.dart';
// import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/forgot_password/presentation/views/forgot_password_view.dart';
import 'package:canc_app/core/shared_feature/forgot_password/presentation/views/otp_view.dart';
import 'package:canc_app/core/shared_feature/login/presentation/views/login_view.dart';
import 'package:canc_app/core/shared_feature/onboarding/presentation/views/language_selection_view.dart';
import 'package:canc_app/core/shared_feature/onboarding/presentation/views/onboarding_view.dart';
import 'package:canc_app/core/shared_feature/who/presentation/views/who_are_you.dart';
import 'package:canc_app/core/shared_feature/sign_up/presentation/views/sign_up_view.dart';
import 'package:canc_app/users/patient/home/presentation/views/patient_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//? GoRouter configuration
final appRouter = GoRouter(
  initialLocation: Routes.homeView,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: Routes.initialRoute,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const Scaffold(
            body: Center(
              child: Text(
                'Welcome to CancApp',
              ),
            ),
          ),
          transitionsBuilder: _transitionsBuilder,
        );
      },
    ),
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

// String _getFirstView() {
//   bool? isFirstTime = getIt<CacheHelper>().getData(key: CacheKeys.onBoarding);
//   if (isFirstTime == null || !isFirstTime) {
//     return Routes.languageSelectionView;
//   }
//   return Routes.whoAreYou;
// }
