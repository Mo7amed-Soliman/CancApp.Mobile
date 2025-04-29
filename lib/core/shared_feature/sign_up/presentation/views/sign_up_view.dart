import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/shared_feature/sign_up/presentation/manger/sign_up_cubit/sign_up_cubit.dart';
import 'package:canc_app/core/shared_feature/sign_up/presentation/views/widgets/sign_up_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => getIt<SignUpCubit>(),
          child: const SignUpViewBody(),
        ),
      ),
    );
  }
}
