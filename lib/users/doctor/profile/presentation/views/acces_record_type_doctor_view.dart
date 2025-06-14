import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/users/doctor/profile/presentation/views/widgets/access_record_type_doctor_view_body.dart';
import 'package:flutter/material.dart';

/// View for displaying specific record types
class AccessRecordTypeDoctorView extends StatelessWidget {
  const AccessRecordTypeDoctorView({
    super.key,
    required this.recordType,
  });

  final String recordType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: recordType,
      ),
      body: AccessRecordTypeDoctorViewBody(),
    );
  }
}
