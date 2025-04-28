import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';

import 'widgets/complete_pharmacy_registration_view_body.dart';

class CompletePharmacyRegistrationView extends StatefulWidget {
  const CompletePharmacyRegistrationView({super.key});

  @override
  State<CompletePharmacyRegistrationView> createState() =>
      _CompletePharmacyRegistrationViewState();
}

class _CompletePharmacyRegistrationViewState
    extends State<CompletePharmacyRegistrationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.06,
        ),
        child: const CompletePharmacyRegistrationViewBody(),
      ),
    );
  }
}
