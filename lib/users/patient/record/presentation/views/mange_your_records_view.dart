import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'widgets/manage_your_record_body.dart';

class MangeYourRecordsView extends StatelessWidget {
  const MangeYourRecordsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).manageYourRecords,
      ),
      body: const ManageYourRecordBody(),
    );
  }
}
