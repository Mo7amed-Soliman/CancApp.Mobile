import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/theming/app_colors.dart';

import 'package:canc_app/core/theming/font_weight_helper.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();
  //! Righteous
  static TextStyle font24RighteousPrimary(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(24),
      fontWeight: FontWeightHelper.semiBold,
      fontFamily: FontFamily.righteous,
      color: AppColors.primaryColor,
    );
  }

  //! Regular
  static TextStyle font14RegularDarkGray(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(14),
      fontWeight: FontWeightHelper.regular,
      color: AppColors.darkGray,
    );
  }

  static TextStyle font20RegularDarkGray(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(20),
      fontWeight: FontWeightHelper.regular,
      color: AppColors.darkGray,
    );
  }

  //! Medium
  static TextStyle font16MediumDarkGray(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(16),
      fontWeight: FontWeightHelper.medium,
      color: AppColors.darkGray,
    );
  }

  static TextStyle font20MediumDarkGray(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(20),
      fontWeight: FontWeightHelper.medium,
      color: AppColors.offWhite,
    );
  }

  //! SemiBold
  static TextStyle font24SemiBoldDarkGray(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(24),
      fontWeight: FontWeightHelper.semiBold,
      color: AppColors.darkGray,
    );
  }

  static TextStyle font20SemiBold(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(20),
      fontWeight: FontWeightHelper.semiBold,
    );
  }
}
