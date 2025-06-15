import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/users/doctor/profile/data/model/record_type_data.dart';
import 'package:canc_app/users/patient/record/data/models/record_type.dart';
import 'package:canc_app/users/patient/record/presentation/views/widgets/record_type_card_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Body widget for the main access record view
class AccessRecordDoctorViewBody extends StatelessWidget {
  const AccessRecordDoctorViewBody({super.key});

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
            final recordTypeData = RecordTypeData(
              index: index,
              recordType: title,
            );
            context.push(
              Routes.accessRecordTypeDoctorView,
              extra: recordTypeData.toJson(),
            );
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
