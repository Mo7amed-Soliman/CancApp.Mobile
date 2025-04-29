import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/login/presentation/views/widgets/login_form.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/auth_prompt_button.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.06),
      child: Column(
        children: [
          const VerticalSpacer(30),
          Align(
            alignment: Alignment.center,
            child: Text(
              S.of(context).cancApp,
              style: AppTextStyle.font28RighteousPrimary(context),
            ),
          ),
          const LoginForm(),
          AuthPromptButton(
            promptText: S.of(context).notHaveAccount,
            actionText: S.of(context).signUp,
            onPressed: () {
              // Dismiss the keyboard
              FocusManager.instance.primaryFocus?.unfocus();
              // Go to sign up
              context.push(Routes.signUpView);
            },
          ),
          const VerticalSpacer(5),
        ],
      ),
    );
  }
}
