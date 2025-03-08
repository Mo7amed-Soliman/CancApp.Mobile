import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_provider.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/routing/app_router.dart';

import 'package:flutter/material.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/core/theming/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CancApp extends StatelessWidget {
  const CancApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizeProvider(
      baseSize: const Size(375, 812),
      width: context.screenWidth,
      height: context.screenHeight,
      child: MaterialApp.router(
        title: appName,
        theme: appLightTheme,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        routerConfig: appRouter,
      ),
    );
  }
}
