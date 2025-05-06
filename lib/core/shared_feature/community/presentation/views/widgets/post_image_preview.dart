import 'dart:io';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';

class PostImagePreview extends StatelessWidget {
  final String imagePath;
  final VoidCallback onRemove;

  const PostImagePreview({
    Key? key,
    required this.imagePath,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(imagePath),
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            onPressed: onRemove,
            icon: const Icon(
              Icons.close,
              color: AppColors.red,
            ),
          ),
        ),
      ],
    );
  }
}
