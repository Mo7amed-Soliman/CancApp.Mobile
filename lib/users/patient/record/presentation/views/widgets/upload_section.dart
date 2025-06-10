import 'dart:io';

import 'package:canc_app/users/patient/record/presentation/views/widgets/display_record_icons.dart';
import 'package:flutter/material.dart';
import 'package:platform_file/platform_file.dart';

class UploadSection extends StatelessWidget {
  const UploadSection({super.key, this.onPick});
 final void Function(File? image, PlatformFile? file)? onPick;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white60,
      height: 255,
      alignment: Alignment.center,
      child: DisplayRecordIcons(
        onPick: onPick,
      ),
    );
  }
}