import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/core/widgets/app_text_form_field.dart';
import 'package:canc_app/core/widgets/password_validations.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../manger/reset_password_cubit/reset_password_cubit.dart';

class ResetPasswordBody extends StatelessWidget {
  const ResetPasswordBody({
    super.key,
    required this.email,
  });
  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          botTextToast(
            S.of(context).passwordResetSuccessfully,
            color: AppColors.darkTeal,
          );
          context.go(Routes.loginView);
        } else if (state is ResetPasswordError) {
          botTextToast(
            state.message,
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: context.read<ResetPasswordCubit>().formKey,
          child: Column(
            children: [
              const Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VerticalSpacer(32),
                          _PasswordInput(),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalSpacer(12),
              AppButtonWidget(
                text: S.of(context).save,
                isLoading: state is ResetPasswordLoading,
                onPressed: () {
                  final cubit = context.read<ResetPasswordCubit>();

                  cubit.performResetPassword(email);
                },
              ),
              const VerticalSpacer(55),
            ],
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    final resetPasswordCubit = context.read<ResetPasswordCubit>();

    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      buildWhen: (previous, current) =>
          current is PasswordVisibilityUpdated ||
          current is PasswordValidationUpdated ||
          current is PasswordMatchUpdated,
      builder: (context, state) {
        return Column(
          children: [
            AppTextFormField(
              label: S.of(context).password,
              obscureText: resetPasswordCubit.isPasswordObscured,
              suffixIcon: resetPasswordCubit.buildVisibilityToggleIcon(),
              onChanged: (password) {
                resetPasswordCubit.updateNewPasswordValidation(password);
              },
              onSaved: (password) {
                resetPasswordCubit.newPasswordInput = password;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).passwordIsRequired;
                }
                if (!resetPasswordCubit.hasLowercase ||
                    !resetPasswordCubit.hasUppercase ||
                    !resetPasswordCubit.hasSpecialCharacters ||
                    !resetPasswordCubit.hasNumber ||
                    !resetPasswordCubit.hasMinLength) {
                  return S.of(context).pleaseEnteraStrongPassword;
                }
                return null;
              },
            ),
            const VerticalSpacer(16),
            AppTextFormField(
              label: S.of(context).confirmPassword,
              obscureText: resetPasswordCubit.isConfirmPasswordObscured,
              suffixIcon:
                  resetPasswordCubit.buildConfirmPasswordVisibilityIcon(),
              onChanged: (confirmPassword) {
                resetPasswordCubit.updateConfirmPassword(confirmPassword);
              },
              onSaved: (confirmPassword) {
                resetPasswordCubit.confirmNewPasswordInput = confirmPassword;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).confirmPasswordIsRequired;
                }
                return resetPasswordCubit.passwordsMatch()
                    ? null
                    : S.of(context).passwordsDonotMatch;
              },
            ),
            const VerticalSpacer(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: PasswordValidations(
                hasLowerCase: resetPasswordCubit.hasLowercase,
                hasUpperCase: resetPasswordCubit.hasUppercase,
                hasSpecialCharacters: resetPasswordCubit.hasSpecialCharacters,
                hasNumber: resetPasswordCubit.hasNumber,
                hasMinLength: resetPasswordCubit.hasMinLength,
              ),
            ),
          ],
        );
      },
    );
  }
}
