import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SearchChatsButton extends StatelessWidget {
  final bool isSearchVisible;
  final VoidCallback onTap;

  const SearchChatsButton({
    super.key,
    required this.isSearchVisible,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: context.setMinSize(20),
        backgroundColor: AppColors.offWhite.withValues(alpha: 0.2),
        child: Icon(
          isSearchVisible ? Icons.close : IconlyLight.search,
          color: AppColors.offWhite,
          size: context.setMinSize(25),
        ),
      ),
    );
  }
}
