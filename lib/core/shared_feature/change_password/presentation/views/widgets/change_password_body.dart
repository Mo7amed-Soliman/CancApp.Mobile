import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/core/widgets/app_text_form_field.dart';
import 'package:canc_app/core/widgets/password_validations.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../manager/change_password_cubit.dart';
import '../../manager/change_password_state.dart';

class ChangePasswordBody extends StatelessWidget {
  const ChangePasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          context.pop();
          botTextToast(
            S.of(context).changePasswordSuccessfully,
            color: AppColors.darkTeal,
          );
        }
        if (state is ChangePasswordError) {
          botTextToast(state.message);
        }
      },
      builder: (context, state) {
        return Form(
          key: context.read<ChangePasswordCubit>().formKey,
          autovalidateMode: context.read<ChangePasswordCubit>().validationMode,
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
                isLoading: state is ChangePasswordLoading,
                onPressed: () async {
                  final cubit = context.read<ChangePasswordCubit>();

                  await cubit.performChangePassword();
                },
              ),
              const VerticalSpacer(20),
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
    final changePasswordCubit = context.read<ChangePasswordCubit>();

    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      buildWhen: (previous, current) =>
          current is PasswordVisibilityUpdated ||
          current is PasswordValidationUpdated ||
          current is PasswordMatchUpdated,
      builder: (context, state) {
        return Column(
          children: [
            AppTextFormField(
              label: S.of(context).oldPassword,
              obscureText: changePasswordCubit.isOldPasswordObscured,
              suffixIcon: changePasswordCubit.buildOldPasswordVisibilityIcon(),
              onSaved: (oldPassword) {
                changePasswordCubit.oldPasswordInput = oldPassword;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).oldPasswordRequired;
                }
                return null;
              },
            ),
            const VerticalSpacer(16),
            AppTextFormField(
              label: S.of(context).newPassword,
              obscureText: changePasswordCubit.isNewPasswordObscured,
              suffixIcon: changePasswordCubit.buildNewPasswordVisibilityIcon(),
              onChanged: (password) {
                changePasswordCubit.updateNewPasswordValidation(password);
              },
              onSaved: (password) {
                changePasswordCubit.newPasswordInput = password;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).newPasswordRequired;
                }
                if (!changePasswordCubit.hasLowercase ||
                    !changePasswordCubit.hasUppercase ||
                    !changePasswordCubit.hasSpecialCharacters ||
                    !changePasswordCubit.hasNumber ||
                    !changePasswordCubit.hasMinLength) {
                  return S.of(context).pleaseEnteraStrongPassword;
                }
                return null;
              },
            ),
            const VerticalSpacer(16),
            AppTextFormField(
              label: S.of(context).confirmNewPassword,
              obscureText: changePasswordCubit.isConfirmPasswordObscured,
              suffixIcon:
                  changePasswordCubit.buildConfirmPasswordVisibilityIcon(),
              onChanged: (confirmPassword) {
                changePasswordCubit.updateConfirmPassword(confirmPassword);
              },
              onSaved: (confirmPassword) {
                changePasswordCubit.confirmNewPasswordInput = confirmPassword;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).confirmPasswordRequired;
                }
                return changePasswordCubit.passwordsMatch()
                    ? null
                    : S.of(context).passwordsDonotMatch;
              },
            ),
            const VerticalSpacer(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: PasswordValidations(
                hasLowerCase: changePasswordCubit.hasLowercase,
                hasUpperCase: changePasswordCubit.hasUppercase,
                hasSpecialCharacters: changePasswordCubit.hasSpecialCharacters,
                hasNumber: changePasswordCubit.hasNumber,
                hasMinLength: changePasswordCubit.hasMinLength,
              ),
            ),
          ],
        );
      },
    );
  }
}
