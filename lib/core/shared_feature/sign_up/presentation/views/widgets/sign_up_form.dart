import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/sign_up/presentation/manger/sign_up_cubit.dart';
import 'package:canc_app/core/shared_feature/sign_up/presentation/views/widgets/sign_up_fields.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpCubit = context.read<SignUpCubit>();

    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          botTextToast(
            '${S.of(context).signUpSuccessful} , ${S.of(context).pleaseVerifyYourEmail}',
            color: AppColors.darkTeal,
          );
          context.go(
            Routes.otpView,
            extra: signUpCubit.emailInput,
          );
        }
        if (state is SignUpFailed) {
          botTextToast(state.errMessage);
        }
      },
      builder: (context, state) {
        return AutofillGroup(
          child: Form(
            key: signUpCubit.formKey,
            autovalidateMode: signUpCubit.validationMode,
            child: Expanded(
              child: Column(
                children: [
                  const Expanded(
                    child: SignUpFields(),
                  ),
                  _SignUpButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpCubit, SignUpState, bool>(
      selector: (state) => state is SignUpLoading,
      builder: (context, isLoading) {
        return AppButtonWidget(
          isLoading: isLoading,
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            context.read<SignUpCubit>().performSignUp();
          },
          text: S.of(context).signUp,
        );
      },
    );
  }
}
