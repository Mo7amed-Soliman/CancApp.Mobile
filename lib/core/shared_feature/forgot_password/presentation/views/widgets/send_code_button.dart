// Send Code Button Widget
import 'package:canc_app/core/shared_feature/forgot_password/presentation/manger/forgot_password_cubit.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendCodeButton extends StatelessWidget {
  const SendCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        return AppButtonWidget(
          isLoading: state is LoadingSendCodeState,
          onPressed: () {
            // Dismiss the keyboard
            FocusManager.instance.primaryFocus?.unfocus();

            // Perform forgot password send code
            context.read<ForgotPasswordCubit>().sendCode();
          },
          text: S.of(context).sendCode,
        );
      },
    );
  }
}
