import 'dart:io';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';

class PhotoCard extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onTap;
  final IconData placeholderIcon;
  final String placeholderText;
  final String subText;

  const PhotoCard({
    super.key,
    required this.imageFile,
    required this.onTap,
    required this.placeholderIcon,
    required this.placeholderText,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: context.setHeight(220),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xfff9fafb),
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(16),
          ),
          child: imageFile == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(placeholderIcon, size: 48, color: AppColors.lightTeal),
                    const VerticalSpacer(8),
                    Text(
                      placeholderText,
                      textAlign: TextAlign.center,
                      style:
                          AppTextStyle.font14RegularDarkGray(context).copyWith(
                        color: Colors.grey[800],
                      ),
                    ),
                    const VerticalSpacer(4),
                    Text(
                      subText,
                      textAlign: TextAlign.center,
                      style:
                          AppTextStyle.font12MediumDarkGray(context).copyWith(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    imageFile!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
        ),
      ),
    );
  }
}
