import 'package:flutter/material.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CancApp extends StatelessWidget {
  const CancApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CancApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const Scaffold(),
    );
  }
}
