import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import '../manger/complete_doctor_registration_cubit/complete_doctor_registration_cubit.dart';
import 'widgets/complete_doctor_registration_view_body.dart';

class CompleteDoctorRegistrationView extends StatelessWidget {
  const CompleteDoctorRegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CompleteDoctorRegistrationCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.offWhite,
          toolbarHeight: 0,
        ),
        body: const CompleteDoctorRegistrationViewBody(),
      ),
    );
  }
}
