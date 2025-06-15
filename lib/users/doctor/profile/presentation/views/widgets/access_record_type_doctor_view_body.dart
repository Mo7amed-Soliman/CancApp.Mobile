import 'package:canc_app/core/widgets/in_empty_list.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/doctor/chat/presentation/views/widgets/chat_list_shimmer.dart';
import 'package:canc_app/users/doctor/profile/presentation/manager/access_record_type_doctor_cubit/access_record_type_doctor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/access_record_type_doctor_cubit/access_record_type_doctor_state.dart';
import 'access_record_doctor_item.dart';

/// Body widget for the record type view
class AccessRecordTypeDoctorViewBody extends StatelessWidget {
  const AccessRecordTypeDoctorViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessRecordTypeDoctorCubit,
        AccessRecordTypeDoctorState>(
      builder: (context, state) {
        if (state is AccessRecordTypeDoctorLoading) {
          return const ChatListShimmer();
        }
        if (state is AccessRecordTypeDoctorError) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        if (state is AccessRecordTypeDoctorSuccess) {
          return state.records.isEmpty
              ? InEmptyList(title: S.of(context).noRecordsFound)
              : ListView.builder(
                  itemCount: state.records.length,
                  itemBuilder: (context, index) {
                    return AccessRecordDoctorItem(
                      record: state.records[index],
                    );
                  },
                );
        }
        return InEmptyList(title: S.of(context).noRecordsFound);
      },
    );
  }
}
