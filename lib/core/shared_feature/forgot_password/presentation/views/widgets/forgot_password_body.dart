import 'package:canc_app/core/shared_feature/forgot_password/presentation/views/widgets/forgot_password_form.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(
          child: VerticalSpacer(32),
        ),
        // Reset Password Instructions
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).forgotPassword,
                style: AppTextStyle.font24SemiBoldDarkGray(context),
              ),
              const VerticalSpacer(8),
              Text(
                S.of(context).resetPasswordInstructions,
                style: AppTextStyle.font16MediumDarkGray(context),
              ),
            ],
          ),
        ),
        const SliverFillRemaining(
          child: ForgotPasswordForm(),
        ),
      ],
    );
  }
}
