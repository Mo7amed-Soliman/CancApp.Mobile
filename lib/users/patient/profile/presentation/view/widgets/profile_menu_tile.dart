import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color iconColor;
  final Color textColor;

  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = AppColors.primaryColor,
    this.textColor = AppColors.darkGray,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        tileColor: const Color(0xFF97D5D1).withAlpha(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        leading: Icon(
          icon,
          size: 30,
          color: iconColor,
        ),
        title: Text(
          title,
          style: AppTextStyle.font17Medium(context).copyWith(color: textColor),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 20,
        ),
        onTap: onTap,
      ),
    );
  }
}
