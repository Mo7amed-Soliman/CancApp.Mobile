import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/login/presentation/manger/login_cubit.dart';
import 'package:canc_app/core/shared_feature/login/presentation/views/widgets/forgot_password_button.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/core/widgets/app_text_form_field.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          // Handle successful login
        }
        if (state is LoginFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }
      },
      child: AutofillGroup(
        child: Form(
          key: loginCubit.formKey,
          autovalidateMode: loginCubit.validationMode,
          child: const Expanded(
            child: Column(
              children: [
                Expanded(child: _LoginFields()),
                _LoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return AppButtonWidget(
      isLoading: context.watch<LoginCubit>().state is LoginLoading,
      onPressed: () {
        // Dismiss the keyboard
        FocusManager.instance.primaryFocus?.unfocus();
        // Perform login
        context.read<LoginCubit>().performLogin();
      },
      text: S.of(context).login,
    );
  }
}

class _LoginFields extends StatelessWidget {
  const _LoginFields();
  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpacer(30),
          Text(
            S.of(context).welcomeBack,
            style: AppTextStyle.font18SemiBoldDarkGray(context),
          ),
          const VerticalSpacer(30),
          AppTextFormField(
            label: S.of(context).email,
            onSaved: (email) => loginCubit.emailInput = email,
            autofillHints: [AutofillHints.email],
          ),
          const VerticalSpacer(12),
          const _PasswordInput(),
          const VerticalSpacer(10),
          ForgotPasswordButton(
            onPressed: () {
              context.push(Routes.forgotPasswordView);
            },
          ),
          const VerticalSpacer(30),
        ],
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();

    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => current is PasswordVisibilityUpdated,
      builder: (context, state) {
        return AppTextFormField(
          label: S.of(context).password,
          autofillHints: [AutofillHints.password],
          obscureText: loginCubit.isPasswordObscured,
          suffixIcon: loginCubit.buildVisibilityToggleIcon(),
          onSaved: (password) => loginCubit.passwordInput = password,
        );
      },
    );
  }
}
