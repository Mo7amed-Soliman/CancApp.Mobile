import 'package:flutter/material.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';

class HealthQuestionRow extends StatelessWidget {
  final String question;
  final int? selectedValue;
  final Function(int) onResponse;

  const HealthQuestionRow({
    super.key,
    required this.question,
    required this.selectedValue,
    required this.onResponse,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: AppTextStyle.font17Medium(context),
        ),
        const VerticalSpacer(8),
        Row(
          children: [
            Expanded(
              child: _ResponseButton(
                text: 'Yes',
                isSelected: selectedValue == 8,
                onPressed: () => onResponse(8),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _ResponseButton(
                text: 'No',
                isSelected: selectedValue == 1,
                onPressed: () => onResponse(1),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ResponseButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const _ResponseButton({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected ? AppColors.primaryColor : Colors.grey[200],
          foregroundColor: isSelected ? AppColors.offWhite : Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
        child: Text(
          text,
          style: AppTextStyle.font16MediumDarkGray(context).copyWith(
            color: isSelected ? AppColors.offWhite : AppColors.grayish,
          ),
        ),
      ),
    );
  }
}
