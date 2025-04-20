import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/custom_text_field.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setMinSize(16),
      ),
      child: CustomTextField(
        hintText: S.of(context).search,
        hintColor: AppColors.grayish,
        textColor: AppColors.grayish,
        fillColor: AppColors.lightGray,
        filled: true,
        prefixIcon: const Icon(
          IconlyLight.search,
          color: AppColors.grayish,
        ),
      ),
    );
  }
}
