import 'dart:io';

import 'package:platform_file/platform_file.dart';
import 'package:uuid/uuid.dart';

class RecordModel {
  String id = const Uuid().v4();
  File? image;
  String note;
  String date;
  PlatformFile? file;

  RecordModel({
    required this.date,
    required this.note,
    this.file,
    this.image,
  });
}
