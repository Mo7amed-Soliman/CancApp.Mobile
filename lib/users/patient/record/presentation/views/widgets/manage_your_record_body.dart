import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/users/patient/record/data/models/record_type.dart';
import 'package:flutter/material.dart';
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
            switch (record) {
              case RecordType.scan:
                // TODO: navigate to page that show all records of type scan  (take type of scan)
                break;
              case RecordType.prescription:
                // TODO: navigate to page that show all records of type prescription (take type of prescription)
                break;
              case RecordType.documents:
                // TODO: navigate to page that show all records of type documents (take type of documents)
                break;
              case RecordType.labResult:
                // TODO: navigate to page that show all records of type lab result (take type of lab result)
                break;
            }
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
