import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/users/doctor/profile/presentation/manager/access_record_type_doctor_cubit/access_record_type_doctor_cubit.dart';
import 'package:canc_app/users/doctor/profile/presentation/views/widgets/access_record_type_doctor_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// View for displaying specific record types
class AccessRecordTypeDoctorView extends StatelessWidget {
  const AccessRecordTypeDoctorView({
    super.key,
    required this.recordTypeAndIndex,
  });

  final ({int index, String recordType}) recordTypeAndIndex;

  String _getRecordType(int index) {
    switch (index) {
      case 0:
        return 'Scan';
      case 1:
        return 'LabResult';
      case 2:
        return 'Prescription';
      case 3:
        return 'Document';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AccessRecordTypeDoctorCubit>()
        ..loadRecords(
          _getRecordType(recordTypeAndIndex.index),
          recordTypeAndIndex.index.toString(),
          UserCacheHelper.getUser()?.id ?? '',
        ),
      child: Scaffold(
        appBar: CustomAppBar(
          title: recordTypeAndIndex.recordType,
        ),
        body: const AccessRecordTypeDoctorViewBody(),
      ),
    );
  }
}
