import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/onboarding/presentation/views/language_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//? GoRouter configuration
final appRouter = GoRouter(
  initialLocation: Routes.languageSelectionView,
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
