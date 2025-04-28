import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
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
    required this.isForgetPassword,
  });

  final bool isForgetPassword;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is FailedVerifyCodeState) {
          botTextToast(state.errorMessage);
        }
        if (state is SuccessVerifyCodeState) {
          if (isForgetPassword) {
            context.push(Routes.resetPasswordView);
          } else {
            botTextToast(
              S.of(context).emailVerifiedSuccessfully,
              color: AppColors.darkTeal,
            );
            // navigate to login view
            final userType =
                getIt<CacheHelper>().getData(key: CacheKeys.whoAreYou);
            _navigateToNextView(context, userType);
          }
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
                if (isForgetPassword) {
                  context.read<OtpCubit>().verifyCodeForgetPassword();
                } else {
                  context.read<OtpCubit>().verifyCode();
                }
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

  void _navigateToNextView(BuildContext context, String userType) async {
    if (userType == UsersKey.patient) {
      context.go(Routes.homeView);
    } else if (userType == UsersKey.volunteer) {
      context.go(Routes.volunteerView);
    } else if (userType == UsersKey.doctor ||
        userType == UsersKey.psychiatrist) {
      context.go(Routes.completeDoctorRegistrationView);
    } else if (userType == UsersKey.pharmacist) {
      // TODO: navigate to complete profile view for pharmacist

      context.go(Routes.pharmacistView);
    }

    if (userType == UsersKey.patient || userType == UsersKey.volunteer) {
      /// Save is logged in to cache
      await getIt<CacheHelper>().saveData(
        key: CacheKeys.isLoggedIn,
        value: true,
      );
    }
  }
}
