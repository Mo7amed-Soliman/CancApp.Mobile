import 'package:flutter/material.dart';

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
      home: const Scaffold(),
    );
  }
}
