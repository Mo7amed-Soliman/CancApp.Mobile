import 'package:canc_app/core/cubits/current_locale/current_locale_cubit.dart';
import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/database/hive_helper.dart';
import 'package:canc_app/core/helpers/database/secure_cache_helper.dart';
import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/helpers/database/medication_cache_helper.dart';
import 'package:canc_app/core/helpers/database/visit_cache_helper.dart';
import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/app_assets.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/delete_confirmation_dialog.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/reminder/data/models/frequency_enum.dart';
import 'package:canc_app/users/patient/reminder/data/models/frequency_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:hive/hive.dart';

import 'widgets/profile_menu_tile.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<void> _clearAllUserData() async {
    try {
      // Clear Hive data
      final userBox = UserCacheHelper.openUserBox();
      if (userBox.isOpen) await userBox.clear();

      final medicationBox = MedicationCacheHelper.getMedicationRemindersBox();
      if (medicationBox.isOpen) await medicationBox.clear();

      final frequencyBox = Hive.box<Frequency>(HiveHelper.frequencyBox);
      if (frequencyBox.isOpen) await frequencyBox.clear();

      final frequencyDetailsBox =
          Hive.box<FrequencyDetailsModel>(HiveHelper.frequencyDetailsBox);
      if (frequencyDetailsBox.isOpen) await frequencyDetailsBox.clear();

      final visitBox = VisitCacheHelper.getVisitRemindersBox();
      if (visitBox.isOpen) await visitBox.clear();

      // Clear SharedPreferences data
      await getIt<CacheHelper>().put(
        key: CacheKeys.isLoggedIn,
        value: false,
      );

      // Clear SecureStorage data
      await getIt<SecureCacheHelper>().clearAll();
    } catch (e) {
      debugPrint('Error clearing user data: $e');
      // Continue with navigation even if clearing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: context.screenHeight * 0.1,
              width: context.screenWidth,
              color: AppColors.primaryColor,
              alignment: Alignment.topCenter,
              child: Text(
                S.of(context).myProfile,
                style: AppTextStyle.font20MediumWhite(context),
              ),
            ),
            Positioned(
              bottom: -60,
              left: 0,
              right: 0,
              child: Center(
                child: CircleAvatar(
                  radius: 53,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 52,
                    backgroundImage:
                        NetworkImage(UserCacheHelper.getUser()?.image ?? ''),
                  ),
                ),
              ),
            ),
          ],
        ),
        const VerticalSpacer(62),
        Text(
          UserCacheHelper.getUser()!.name,
          style: AppTextStyle.font20SemiBold(context),
        ),
        const VerticalSpacer(15),
        ProfileMenuTile(
          icon: IconlyLight.profile,
          title: S.of(context).editProfile,
          onTap: () async {
            await context.push(Routes.editProfileView).then((value) {
              if (context.mounted) {
                setState(() {});
              }
            });
          },
        ),
        ProfileMenuTile(
          icon: IconlyLight.password,
          title: S.of(context).changePassword,
          onTap: () {
            context.push(Routes.changePassword);
          },
        ),
        ProfileMenuTile(
          svgPath: AppAssets.languageIcon,
          title: isArabic()
              ? S.of(context).switchToEnglish
              : S.of(context).switchToArabic,
          onTap: () {
            const englishToArabicMessage = 'تم التحويل إلى اللغة العربية';
            const arabicToEnglishMessage = 'Switched to English language';

            showSuccessToast(
              isArabic() ? arabicToEnglishMessage : englishToArabicMessage,
            );
            context.read<CurrentLocaleCubit>().changeLocale(
                  isArabic() ? LocaleType.en : LocaleType.ar,
                );
          },
        ),
        ProfileMenuTile(
          icon: IconlyLight.logout,
          title: S.of(context).logout,
          iconColor: AppColors.red,
          textColor: AppColors.red,
          onTap: () {
            DeleteConfirmationDialog.show(
              context,
              content: S.of(context).logout_confirm,
              confirmText: S.of(context).confirm,
              onConfirm: () async {
                await getIt<CacheHelper>().put(
                  key: CacheKeys.isLoggedIn,
                  value: false,
                );

                await _clearAllUserData();
                if (context.mounted) {
                  context.go(Routes.whoAreYou);
                }
              },
            );
          },
        ),
      ],
    );
  }
}
