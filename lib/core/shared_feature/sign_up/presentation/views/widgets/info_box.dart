import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/core/theming/app_colors.dart';

class InfoBox extends StatelessWidget {
  final List<String> points;

  const InfoBox({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFf3faf9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.red.withAlpha(230)),
              const SizedBox(width: 8),
              Text(
                'Photo requirements:',
                style: AppTextStyle.font14RegularDarkGray(context).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...points.map(
            (text) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      '• $text',
                      style: AppTextStyle.font12MediumDarkGray(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
