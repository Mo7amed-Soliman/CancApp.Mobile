import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/shared_feature/login/presentation/manger/login_cubit.dart';
import 'package:canc_app/core/shared_feature/login/presentation/views/widgets/login_fields.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          /// Handle successful login
          // context.push(Routes.completeProfileView);
          botTextToast(
            'Login successful \n welcome ${state.userModel.name}👋',
            color: AppColors.darkTeal,
          );
        }
        if (state is LoginFailed) {
          botTextToast(state.errMessage);
          debugPrint(state.errMessage);
        }
      },
      builder: (context, state) => AutofillGroup(
        child: Form(
          key: loginCubit.formKey,
          autovalidateMode: loginCubit.validationMode,
          child: const Expanded(
            child: Column(
              children: [
                Expanded(
                  child: LoginFields(),
                ),
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
        /// Dismiss the keyboard
        FocusManager.instance.primaryFocus?.unfocus();

        /// Perform login
        context.read<LoginCubit>().performLogin();

        /// Go to complete profile
      },
      text: S.of(context).login,
    );
  }
}
