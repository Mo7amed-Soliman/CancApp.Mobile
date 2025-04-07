import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/theming/app_colors.dart';

import 'package:canc_app/core/theming/font_weight_helper.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();
  static String fontFamily =
      isArabic() ? FontFamily.almarai : FontFamily.poppins;

  //! Righteous
  static TextStyle font28RighteousPrimary(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(28),
      fontWeight:
          isArabic() ? FontWeightHelper.semiBold : FontWeightHelper.regular,
      fontFamily: isArabic() ? FontFamily.almarai : FontFamily.righteous,
      color: AppColors.primaryColor,
    );
  }

  //! Regular
  static TextStyle font14RegularDarkGray(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(14),
      fontWeight: FontWeightHelper.regular,
      color: AppColors.darkGray,
      fontFamily: fontFamily,
    );
  }

  static TextStyle font16RegularDarkGray(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(16),
      fontWeight: FontWeightHelper.regular,
      color: AppColors.darkGray,
      fontFamily: fontFamily,
    );
  }

  static TextStyle font20RegularDarkGray(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(20),
      fontWeight: FontWeightHelper.regular,
      color: AppColors.darkGray,
      fontFamily: fontFamily,
    );
  }

  //! Medium
  static TextStyle font16MediumDarkGray(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(16),
      fontWeight: FontWeightHelper.medium,
      color: AppColors.darkGray,
      fontFamily: fontFamily,
    );
  }

  static TextStyle font12MediumDarkGray(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(12),
      fontWeight: FontWeightHelper.medium,
      color: AppColors.darkGray,
      fontFamily: fontFamily,
    );
  }

  static TextStyle font20MediumWhite(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(20),
      fontWeight: FontWeightHelper.medium,
      color: AppColors.offWhite,
      fontFamily: fontFamily,
    );
  }

  //! SemiBold
  static TextStyle font24SemiBoldDarkGray(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(24),
      fontWeight: FontWeightHelper.semiBold,
      color: AppColors.darkGray,
      fontFamily: fontFamily,
    );
  }

  static TextStyle font18SemiBoldDarkGray(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(18),
      fontWeight: FontWeightHelper.semiBold,
      color: AppColors.darkGray,
      fontFamily: fontFamily,
    );
  }

  static TextStyle font19MediumDarkGray(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(19),
      fontWeight: FontWeightHelper.medium,
      color: AppColors.darkGray,
      fontFamily: fontFamily,
    );
  }

  static TextStyle font20SemiBold(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(20),
      fontWeight: FontWeightHelper.semiBold,
      fontFamily: fontFamily,
    );
  }

  static TextStyle font16SemiBoldWhite(BuildContext context) {
    return TextStyle(
      color: Colors.white,
      fontSize: context.setSp(16),
      fontWeight: FontWeightHelper.semiBold,
      height: 17.0 / 16.0,
      fontFamily: fontFamily,
    );
  }

  static TextStyle font15Bold(BuildContext context) {
    return TextStyle(
      fontSize: context.setSp(15),
      fontWeight: FontWeightHelper.bold,
      fontFamily: fontFamily,
    );
  }

  static TextStyle font14SemiBoldWhite(BuildContext context) {
    return TextStyle(
      color: Colors.white,
      fontSize: context.setSp(14),
      fontWeight: FontWeightHelper.light,
      height: 17.0 / 14.0,
      fontFamily: fontFamily,
    );
  }
}
