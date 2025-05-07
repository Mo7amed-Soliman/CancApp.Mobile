import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/nearest_pharmacy_cubit/nearest_pharmacy_cubit.dart';
import 'widgets/main_content.dart';
import 'widgets/welcome_banner.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return getIt<NearestPharmacyCubit>()..getNearestPharmacies();
      },
      child: const Column(
        children: [
          /// Welcome Banner
          WelcomeBanner(),

          /// Main Content
          MainContent()
        ],
      ),
    );
  }
}
