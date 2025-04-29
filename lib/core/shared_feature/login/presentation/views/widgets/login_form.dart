import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/login/presentation/manger/login_cubit.dart';
import 'package:canc_app/core/shared_feature/login/presentation/views/widgets/login_fields.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          /// Handle successful login
          _navigateToNextView(context, state.userModel.userType);
          botTextToast(
            '${S.of(context).loginSuccessfully} \n ${S.of(context).welcome} ${state.userModel.name}👋',
            color: AppColors.darkTeal,
          );

          /// Save is logged in to cache
          await getIt<CacheHelper>().saveData(
            key: CacheKeys.isLoggedIn,
            value: true,
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

  void _navigateToNextView(BuildContext context, String userType) {
    if (userType == UsersKey.patient) {
      context.go(Routes.homeView);
    } else if (userType == UsersKey.volunteer) {
      context.go(Routes.volunteerView);
    } else if (userType == UsersKey.doctor) {
      context.go(Routes.doctorView);
    } else if (userType == UsersKey.pharmacist) {
      context.go(Routes.pharmacistView);
    } else if (userType == UsersKey.psychiatrist) {
      context.go(Routes.psychiatristView);
    } else if (userType == UsersKey.admin) {
      // TODO : navigate to admin view
      context.go(Routes.homeView);
    }
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
