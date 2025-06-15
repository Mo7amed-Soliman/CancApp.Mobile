import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/in_empty_list.dart';
import 'package:canc_app/users/doctor/chat/presentation/views/widgets/chat_list_shimmer.dart';
import 'package:canc_app/users/doctor/profile/data/model/access_record_model.dart';
import 'package:canc_app/users/doctor/profile/data/model/access_request_doctor_model.dart';
import 'package:canc_app/users/doctor/profile/presentation/manager/access_requests_doctor_cubit/access_requests_doctor_cubit.dart';
import 'package:canc_app/users/doctor/profile/presentation/manager/access_requests_doctor_cubit/access_requests_doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AcceptedRequestList extends StatelessWidget {
  const AcceptedRequestList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AccessRequestsDoctorCubit>(context);
    return BlocBuilder<AccessRequestsDoctorCubit, AccessRequestsDoctorState>(
      builder: (context, state) {
        if (state is AccessRequestsDoctorLoading) {
          return const ChatListShimmer();
        }
        if (state is AccessRequestsDoctorError) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is AcceptedRequestsDoctorLoaded ||
            state is SendRequestsDoctorLoaded) {
          return cubit.acceptedRequests.isEmpty
              ? const InEmptyList(title: 'No accepted requests')
              : NewWidget(acceptedRequests: cubit.acceptedRequests);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.acceptedRequests,
  });

  final List<AccessRequestDoctorModel> acceptedRequests;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 5),
      itemCount: acceptedRequests.length,
      itemBuilder: (context, index) {
        final request = acceptedRequests[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 0,
            color: Colors.white,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  request.image,
                ),
              ),
              title: Text(
                request.name,
                style: AppTextStyle.font19MediumDarkGray(context),
              ),
              subtitle: Text(
                request.address,
                style: AppTextStyle.font14RegularDarkGray(context),
              ),
              onTap: () {
                final accessRecord = AccessRecordModel(
                  patientId: request.userId,
                  patientName: request.name,
                  patientImage: request.image,
                );
                context.push(
                  Routes.accessRecordView,
                  extra: accessRecord.toJson(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
