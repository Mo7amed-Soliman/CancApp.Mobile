import 'package:canc_app/core/shared_feature/sign_up/presentation/manger/sign_up_cubit/sign_up_cubit.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/app_text_form_field.dart';
import 'package:canc_app/core/widgets/password_validations.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpFields extends StatelessWidget {
  const SignUpFields({super.key});
  @override
  Widget build(BuildContext context) {
    final signUpCubit = context.read<SignUpCubit>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpacer(30),
          Text(
            S.of(context).createYourAccount,
            style: AppTextStyle.font18SemiBoldDarkGray(context),
          ),
          const VerticalSpacer(30),
          AppTextFormField(
            label: S.of(context).fullName,
            onSaved: (fullNmae) => signUpCubit.fullNameInput = fullNmae,
            autofillHints: [AutofillHints.name],
          ),
          const VerticalSpacer(12),
          AppTextFormField(
            label: S.of(context).address,
            onSaved: (address) => signUpCubit.addressInput = address,
            autofillHints: const [
              AutofillHints.fullStreetAddress, // Full street address
              AutofillHints.postalAddress, // Postal address (generic)
              AutofillHints.streetAddressLine1, // First line of street address
              AutofillHints.streetAddressLine2, // Second line of street address
              AutofillHints.location, // Generic location hint
              AutofillHints.addressCityAndState, // City + State combination
            ],
            keyboardType: TextInputType.streetAddress,
          ),
          const VerticalSpacer(12),
          AppTextFormField(
            label: S.of(context).email,
            onSaved: (email) => signUpCubit.emailInput = email,
            autofillHints: [AutofillHints.email],
          ),
          const VerticalSpacer(12),
          const _PasswordInput(),
          const VerticalSpacer(24),
        ],
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    final signUpCubit = context.read<SignUpCubit>();

    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          current is PasswordVisibilityUpdated ||
          current is PasswordValidationUpdated ||
          current is PasswordMatchUpdated,
      builder: (context, state) {
        return Column(
          children: [
            const VerticalSpacer(12),
            AppTextFormField(
              label: S.of(context).password,
              obscureText: signUpCubit.isPasswordObscured,
              suffixIcon: signUpCubit.buildVisibilityToggleIcon(),
              onChanged: (password) {
                signUpCubit.updatePasswordValidation(password);
              },
              onSaved: (password) {
                signUpCubit.passwordInput = password;
              },
              validator: (value) {
                if (value == null) {
                  return S.of(context).passwordIsRequired;
                }
                if (!signUpCubit.hasLowercase ||
                    !signUpCubit.hasUppercase ||
                    !signUpCubit.hasSpecialCharacters ||
                    !signUpCubit.hasNumber ||
                    !signUpCubit.hasMinLength) {
                  return S.of(context).pleaseEnteraStrongPassword;
                }
                return null;
              },
            ),
            const VerticalSpacer(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: PasswordValidations(
                hasLowerCase: signUpCubit.hasLowercase,
                hasUpperCase: signUpCubit.hasUppercase,
                hasSpecialCharacters: signUpCubit.hasSpecialCharacters,
                hasNumber: signUpCubit.hasNumber,
                hasMinLength: signUpCubit.hasMinLength,
              ),
            ),
            const VerticalSpacer(12),
            AppTextFormField(
              label: S.of(context).confirmPassword,
              obscureText: signUpCubit.isConfirmPasswordObscured,
              suffixIcon: signUpCubit.buildConfirmPasswordVisibilityIcon(),
              onChanged: (confirmPassword) {
                signUpCubit.updateConfirmPassword(confirmPassword);
              },
              onSaved: (confirmPassword) {
                signUpCubit.confirmPasswordInput = confirmPassword;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).confirmPasswordIsRequired;
                }
                return signUpCubit.passwordsMatch()
                    ? null
                    : S.of(context).passwordsDonotMatch;
              },
            ),
          ],
        );
      },
    );
  }
}
