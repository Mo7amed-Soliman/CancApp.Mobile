import 'dart:io';

import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

import 'info_box.dart';
import 'photo_card.dart';

class UploadPhotoSection extends StatelessWidget {
  final String title;
  final File? imageFile;
  final VoidCallback onTap;
  final IconData placeholderIcon;
  final String placeholderText;
  final String subText;
  final List<String> infoPoints;

  const UploadPhotoSection({
    super.key,
    required this.title,
    required this.imageFile,
    required this.onTap,
    required this.placeholderIcon,
    required this.placeholderText,
    required this.subText,
    required this.infoPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.font16RegularDarkGray(context),
        ),
        const SizedBox(height: 12),
        PhotoCard(
          imageFile: imageFile,
          onTap: onTap,
          placeholderIcon: placeholderIcon,
          placeholderText: placeholderText,
          subText: subText,
        ),
        InfoBox(points: infoPoints),
      ],
    );
  }
}
