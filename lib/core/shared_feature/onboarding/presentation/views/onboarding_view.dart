import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/app_assets.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/onboarding/presentation/widgets/onboarding_content_widget.dart';
import 'package:canc_app/core/shared_feature/onboarding/presentation/widgets/flutter_onboarding_slider.dart';
import 'package:canc_app/core/shared_feature/who/presentation/widgets/user_role_selection_widget.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  String selectedRoleKey = 'Doctor'; // Default role key

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isArabic() ? TextDirection.rtl : TextDirection.ltr,
      child: OnBoardingSlider(
        pageBackgroundColor: AppColors.offWhite,
        indicatorAbove: true,
        finishButtonText: S.of(context).next,
        backButtonText: S.of(context).back,
        finishButtonTextStyle: AppTextStyle.font20MediumWhite(context),
        onFinish: () {
          context.push(Routes.loginView);
          getIt<CacheHelper>()
              .saveData(key: CacheKeys.whoAreYou, value: selectedRoleKey);
        },
        finishButtonStyle: _buildFinishButtonStyle(context),
        skipTextButton: _buildSkipTextButton(context),
        controllerColor: AppColors.primaryColor,
        totalPage: 5,
        headerBackgroundColor: AppColors.offWhite,
        pageBodies: _buildPageBodies(context),
      ),
    );
  }

  FinishButtonStyle _buildFinishButtonStyle(BuildContext context) {
    return FinishButtonStyle(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          context.setMinSize(10),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
    );
  }

  Text _buildSkipTextButton(BuildContext context) {
    return Text(
      S.of(context).skip,
      style: AppTextStyle.font16MediumDarkGray(context),
    );
  }

  List<Widget> _buildPageBodies(BuildContext context) {
    return [
      OnboardingContent(
        image: AppAssets.onboarding1,
        title: S.of(context).onboarding_title1,
        description: S.of(context).onboarding_description1,
      ),
      OnboardingContent(
        image: AppAssets.onboarding2,
        title: S.of(context).onboarding_title2,
        description: S.of(context).onboarding_description2,
      ),
      OnboardingContent(
        image: AppAssets.onboarding3,
        title: S.of(context).onboarding_title3,
        description: S.of(context).onboarding_description3,
      ),
      OnboardingContent(
        image: AppAssets.onboarding4,
        title: S.of(context).onboarding_title4,
        description: S.of(context).onboarding_description4,
      ),
      UserRoleSelectionWidget(
        selectedRoleKey: selectedRoleKey,
        onRoleSelected: (key) => setState(() => selectedRoleKey = key),
      ),
    ];
  }
}
