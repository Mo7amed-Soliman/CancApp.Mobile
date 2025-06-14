import 'package:canc_app/users/doctor/profile/data/model/record_doctor_model.dart';
import 'package:canc_app/users/doctor/profile/presentation/views/widgets/access_record_doctor_item.dart';
import 'package:flutter/material.dart';

/// Body widget for the record type view
class AccessRecordTypeDoctorViewBody extends StatelessWidget {
  AccessRecordTypeDoctorViewBody({
    super.key,
  });
  //TODO load records from cubit
  final List<RecordDoctorModel> records = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        return AccessRecordDoctorItem(
          record: records[index],
        );
      },
    );
  }
}
