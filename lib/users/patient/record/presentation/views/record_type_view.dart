import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/users/patient/record/data/models/record_type.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:iconly/iconly.dart';

import 'widgets/record_type_body.dart';

class RecordTypeView extends StatelessWidget {
  const RecordTypeView({
    super.key,
    required this.recordType,
  });
  final RecordType recordType;

  @override
  Widget build(BuildContext context) {
    final title = isArabic() ? recordType.labelAr : recordType.labelEn;
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        icon: IconlyBold.plus,
        onPressed: () async {
          await GoRouter.of(context)
              .push(Routes.newRecordDetail, extra: [null, recordType.labelEn]);
        },
      ),
      body: RecordTypeBody(recordType: recordType),
    );
  }
}
