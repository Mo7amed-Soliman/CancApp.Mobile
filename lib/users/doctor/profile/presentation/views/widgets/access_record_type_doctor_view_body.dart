import 'package:canc_app/users/doctor/profile/data/model/record_doctor_model.dart';
import 'package:canc_app/users/doctor/profile/presentation/views/widgets/access_record_doctor_item.dart';
import 'package:flutter/material.dart';

/// Body widget for the record type view
class AccessRecordTypeDoctorViewBody extends StatelessWidget {
  const AccessRecordTypeDoctorViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1, // TODO: Replace with actual data count
      itemBuilder: (context, index) {
        return const AccessRecordDoctorItem(
          record: RecordDoctorModel(
            id: '1',
            name: 'John Doe',
            imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
            date: '2021-01-01',
            note: 'Note',
            type: 'Type',
          ),
        );
      },
    );
  }
}
