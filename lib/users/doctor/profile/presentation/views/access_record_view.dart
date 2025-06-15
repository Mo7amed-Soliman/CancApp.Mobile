import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/users/doctor/profile/data/model/access_record_model.dart';
import 'package:canc_app/users/doctor/profile/presentation/views/widgets/access_record_doctor_view_body.dart';
import 'package:flutter/material.dart';

/// Main view for accessing patient records as a doctor
class AccessRecordDoctorView extends StatelessWidget {
  const AccessRecordDoctorView({
    super.key,
    required this.accessRecord,
  });

  final AccessRecordModel accessRecord;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: accessRecord.patientName,
      ),
      body: const AccessRecordDoctorViewBody(),
    );
  }
}
