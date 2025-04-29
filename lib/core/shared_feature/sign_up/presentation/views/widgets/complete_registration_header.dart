import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';

class CompleteRegistrationHeader extends StatelessWidget {
  const CompleteRegistrationHeader({
    super.key,
    required this.title,
    required this.description,
  });
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: context.setMinSize(35),
            backgroundColor: AppColors.primaryColor.withAlpha(25),
            child: Icon(
              Icons.verified_user_outlined,
              size: context.setMinSize(40),
              color: AppColors.lightTeal,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyle.font20SemiBold(context),
            textAlign: TextAlign.center,
          ),
          const VerticalSpacer(4),
          Text(
            description,
            style: AppTextStyle.font16RegularDarkGray(context).copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
