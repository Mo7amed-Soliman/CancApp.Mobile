import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/shared_feature/login/presentation/manager/login_cubit.dart';
import 'package:canc_app/core/shared_feature/login/presentation/views/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginViewBody(),
        ),
      ),
    );
  }
}
