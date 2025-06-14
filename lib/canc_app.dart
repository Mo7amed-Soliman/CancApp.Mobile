import 'package:bot_toast/bot_toast.dart';
import 'package:canc_app/core/cubits/current_locale/current_locale_cubit.dart';
import 'package:canc_app/core/cubits/current_locale/current_locale_state.dart';
import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_provider.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/routing/app_router.dart';
import 'package:canc_app/core/shared_feature/community/presentation/manager/comment_cubit/comment_cubit.dart';
import 'package:canc_app/core/shared_feature/community/presentation/manager/community_cubit/community_cubit.dart';

import 'package:flutter/material.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/core/theming/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'users/patient/record/presentation/manager/manage_record/managerecord_cubit.dart';
import 'users/patient/record/presentation/manager/manage_record_image/manage_upload_image_cubit.dart';

class CancApp extends StatelessWidget {
  const CancApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CurrentLocaleCubit()..loadLocale(),
        ),
        BlocProvider(
          create: (context) => ManageUploadImageCubit(),
        ),
        BlocProvider(
          create: (context) => ManagerecordCubit(),
        ),
        BlocProvider(
          create: (context) => getIt<CommunityCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CommentCubit>(),
        ),
      ],
      child: const CustomMaterialApp(),
    );
  }
}

class CustomMaterialApp extends StatelessWidget {
  const CustomMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentLocaleCubit, CurrentLocaleState>(
      builder: (context, state) => SizeProvider(
        baseSize: const Size(360, 800),
        width: context.screenWidth,
        height: context.screenHeight,
        child: MaterialApp.router(
          title: appName,
          theme: appLightTheme,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: context.read<CurrentLocaleCubit>().locale,
          debugShowCheckedModeBanner: false,
          builder: BotToastInit(),
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
