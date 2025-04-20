import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/access_requests_view_body.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/generated/l10n.dart';

class AccessRequestView extends StatelessWidget {
  const AccessRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).accessRequests,
      ),
      body: const AccessRequestsViewBody(),
    );
  }
}
