import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/shared_feature/forgot_password/presentation/manger/forgot_password_cubit.dart';
import 'package:canc_app/core/shared_feature/forgot_password/presentation/views/widgets/forgot_password_body.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocProvider(
        create: (context) => getIt<ForgotPasswordCubit>(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.screenWidth * 0.06,
            ),
            child: const ForgotPasswordBody(),
          ),
        ),
      ),
    );
  }
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    foregroundColor: AppColors.darkGray,
    backgroundColor: AppColors.offWhite,
    elevation: 0,
  );
}
