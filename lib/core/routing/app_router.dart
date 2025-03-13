import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/onboarding/presentation/views/language_selection_view.dart';
import 'package:canc_app/core/shared_feature/onboarding/presentation/views/onboarding_view.dart';
import 'package:canc_app/core/shared_feature/who/presentation/views/who_are_you.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//? GoRouter configuration
final appRouter = GoRouter(
  initialLocation: _getFirstView(),
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
      path: Routes.loginView,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const Scaffold(),
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
  return Routes.loginView;
}
