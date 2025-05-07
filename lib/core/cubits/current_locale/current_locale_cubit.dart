import 'package:canc_app/core/cubits/current_locale/current_locale_state.dart';
import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LocaleType { en, ar }

class CurrentLocaleCubit extends Cubit<CurrentLocaleState> {
  CurrentLocaleCubit() : super(InitialState());
  late Locale locale;
  //? change current locale
  void changeLocale(LocaleType localeType) {
    switch (localeType) {
      case LocaleType.en:
        locale = const Locale('en');
        AppTextStyle.fontFamily = FontFamily.poppins;
        getIt<CacheHelper>().put(key: CacheKeys.language, value: 'en');
        emit(EnglishState());
        break;
      case LocaleType.ar:
        locale = const Locale('ar');
        AppTextStyle.fontFamily = FontFamily.almarai;
        getIt<CacheHelper>().put(key: CacheKeys.language, value: 'ar');
        emit(ArabicState());
        break;
    }
  }

  //? load current locale
  void loadLocale() {
    var language = getIt<CacheHelper>().getData(key: CacheKeys.language);

    if (language != null) {
      if (language == 'en') {
        locale = const Locale('en');
      } else {
        locale = const Locale('ar');
      }
    } else {
      locale = const Locale('ar');
    }
  }
}
