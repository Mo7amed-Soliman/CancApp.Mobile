import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class PostContentField extends StatelessWidget {
  final TextEditingController controller;

  const PostContentField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'What\'s on your mind?',
        border: InputBorder.none,
        hintStyle: AppTextStyle.font15Medium(context).copyWith(
          color: AppColors.darkGray.withOpacity(0.5),
        ),
      ),
      style: AppTextStyle.font15Medium(context),
      maxLines: null,
    );
  }
}
