import 'package:canc_app/users/patient/home/presentation/views/widgets/main_content.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/welcome_banner.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        /// Welcome Banner
        WelcomeBanner(),

        /// Main Content
        MainContent()
      ],
    );
  }
}
