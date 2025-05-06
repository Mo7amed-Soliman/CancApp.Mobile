import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class PostImagePicker extends StatelessWidget {
  final VoidCallback onPickImage;

  const PostImagePicker({
    Key? key,
    required this.onPickImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onPickImage,
          icon: const Icon(
            Icons.image,
            color: AppColors.primaryColor,
          ),
        ),
        Text(
          'Add Photo',
          style: AppTextStyle.font15Medium(context).copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
