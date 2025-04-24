import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/otp/presentation/manger/otp_cubit.dart';
import 'package:canc_app/core/shared_feature/otp/presentation/manger/otp_state.dart';
import 'package:canc_app/core/shared_feature/otp/presentation/view/widgets/otp_input_section.dart';
import 'package:canc_app/core/shared_feature/otp/presentation/view/widgets/verify_button.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'resend_code_button.dart';

class CustomBlocConsumer extends StatelessWidget {
  const CustomBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is FailedVerifyCodeState) {
          botTextToast(state.errorMessage);
        }
        if (state is SuccessVerifyCodeState) {
          botTextToast(
            S.of(context).emailVerifiedSuccessfully,
            color: AppColors.darkTeal,
          );
          // navigate to login view
          context.go(Routes.loginView);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: OTPInput(
                onCompleted: (value) {
                  context.read<OtpCubit>().onChanged(value);
                },
                onChanged: (value) {
                  context.read<OtpCubit>().onChanged(value);
                },
              ),
            ),
            const VerticalSpacer(32),
            VerifyButton(
              isInputFilled: context.read<OtpCubit>().completedCode,
              isLoading: state is LoadingVerifyCodeState,
              onPressed: () {
                context.read<OtpCubit>().verifyCode();
              },
            ),
            ResendCodeButton(
              onPressed: () {
                context.read<OtpCubit>().resendCode();
              },
            ),
          ],
        );
      },
    );
  }
}
