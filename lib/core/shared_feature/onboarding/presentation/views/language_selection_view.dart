import 'package:canc_app/core/cubits/current_locale/current_locale_cubit.dart';
import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/shared_feature/onboarding/presentation/widgets/language_option_widget.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSelectionView extends StatelessWidget {
  const LanguageSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final alignment = isArabic() ? Alignment.centerRight : Alignment.centerLeft;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(backgroundColor: AppColors.offWhite),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.06,
          vertical: context.screenHeight * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              alignment: alignment,
              child: Text(
                S.of(context).selectLanguage,
                style: AppTextStyle.font24SemiBoldDarkGray(context)
                    .copyWith(color: AppColors.primaryColor),
              ),
            ),
            SizedBox(height: context.setHeight(24)),
            LanguageOptionWidget(
              language: S.of(context).english,
              isSelected: !isArabic(),
              alignment: alignment,
              onTap: () => _handleLanguageSelection(context, 'en'),
            ),
            SizedBox(height: context.setHeight(24)),
            LanguageOptionWidget(
              language: S.of(context).arabic,
              isSelected: isArabic(),
              alignment: alignment,
              onTap: () => _handleLanguageSelection(context, 'ar'),
            ),
            const Spacer(),
            AppButtonWidget(
              onPressed: () {},
              text: S.of(context).next,
            ),
          ],
        ),
      ),
    );
  }

  void _handleLanguageSelection(BuildContext context, String langCode) {
    getIt<CacheHelper>().saveData(key: CacheKeys.language, value: langCode);
    final localeType = langCode == 'en' ? LocaleType.en : LocaleType.ar;
    context.read<CurrentLocaleCubit>().changeLocale(localeType);
  }
}
