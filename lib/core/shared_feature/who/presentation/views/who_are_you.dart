import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/user_role_selection_widget.dart';

class WhoAreYou extends StatefulWidget {
  const WhoAreYou({super.key});

  @override
  State<WhoAreYou> createState() => _WhoAreYouState();
}

class _WhoAreYouState extends State<WhoAreYou> {
  String selectedRoleKey = UsersKey.doctor; // Default role key
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: UserRoleSelectionWidget(
              selectedRoleKey: selectedRoleKey,
              onRoleSelected: (key) => setState(() => selectedRoleKey = key),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.screenWidth * 0.06,
              vertical: context.screenHeight * 0.04,
            ),
            child: AppButtonWidget(
              onPressed: () {
                context.push(Routes.loginView);
                getIt<CacheHelper>()
                    .saveData(key: CacheKeys.whoAreYou, value: selectedRoleKey);
              },
              text: S.of(context).next,
            ),
          )
        ],
      ),
    );
  }
}
