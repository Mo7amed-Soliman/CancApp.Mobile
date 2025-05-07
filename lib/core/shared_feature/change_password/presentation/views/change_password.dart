import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/change_password_cubit.dart';
import 'widgets/change_password_body.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: S.of(context).changePassword,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.screenWidth * 0.06,
          ),
          child: const ChangePasswordBody(),
        ),
      ),
    );
  }
}
