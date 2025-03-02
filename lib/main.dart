import 'package:canc_app/canc_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // Set app orientation to portrait mode only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const CancApp());
}
