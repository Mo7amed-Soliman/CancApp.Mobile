import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manger/reset_password_cubit/reset_password_cubit.dart';
import 'widgets/reset_password_body.dart';

class ResetPasswordView extends StatefulWidget {
  final String email;

  const ResetPasswordView({
    super.key,
    required this.email,
  });

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: Scaffold(
        backgroundColor: Colors.white, // Set background to white
        appBar: CustomAppBar(
          title: S.of(context).resetPassword,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.screenWidth * 0.06,
          ),
          child: ResetPasswordBody(
            email: widget.email,
          ),
        ),
      ),
    );
  }
}
