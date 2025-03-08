import 'package:canc_app/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//? GoRouter configuration
final appRouter = GoRouter(
  initialLocation: Routes.initialRoute,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: Routes.onBoardingView,
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
  ],
);

//? slide transition animation helper function
Widget _transitionsBuilder(context, animation, secondaryAnimation, child) {
  final tween = Tween(
    begin: const Offset(1.0, 0.0),
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
