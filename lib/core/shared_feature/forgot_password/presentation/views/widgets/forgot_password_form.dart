import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/forgot_password/presentation/manger/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:canc_app/core/shared_feature/forgot_password/presentation/views/widgets/send_code_button.dart';
import 'package:canc_app/core/widgets/app_text_form_field.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final forgotPasswordCubit = context.read<ForgotPasswordCubit>();
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        // Handle state changes if needed
        if (state is SuccessSensCodeState) {
          botTextToast('Sent code successfully');
          context.push<String>(Routes.otpView,
              extra: forgotPasswordCubit.emailInput);
        }
        if (state is FailedSendCodeState) {
          botTextToast(state.errorMessage);
        }
      },
      child: Column(
        children: [
          const VerticalSpacer(20),
          AutofillGroup(
            child: Form(
              key: forgotPasswordCubit.formKey,
              autovalidateMode: forgotPasswordCubit.validationMode,
              child: AppTextFormField(
                label: S.of(context).email,
                // autofocus: true,
                autofillHints: const [AutofillHints.email],
                onSaved: (email) {
                  forgotPasswordCubit.emailInput = email;
                },
              ),
            ),
          ),
          const Spacer(),
          const VerticalSpacer(32),
          const SendCodeButton(),
          const VerticalSpacer(55),
        ],
      ),
    );
  }
}
