import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/users/patient/record/data/models/record_type.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'record_type_card_item.dart';

class ManageYourRecordBody extends StatelessWidget {
  const ManageYourRecordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: RecordType.values.length,
      itemBuilder: (context, index) {
        final record = RecordType.values[index];
        final title = isArabic() ? record.labelAr : record.labelEn;
        return GestureDetector(
          onTap: () {
            // navigate to record type view
            context.push(Routes.recordTypeView, extra: record);
          },
          child: RecordTypeCardItem(
            title: title,
            image: record.assetPath,
          ),
        );
      },
    );
  }
}
