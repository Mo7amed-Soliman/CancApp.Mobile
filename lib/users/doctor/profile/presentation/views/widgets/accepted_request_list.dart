import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/users/doctor/profile/data/model/access_record_model.dart';
import 'package:canc_app/users/doctor/profile/data/model/access_request_doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AcceptedRequestList extends StatelessWidget {
  const AcceptedRequestList({super.key, required this.acceptedRequests});
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
                style: AppTextStyle.font20SemiBold(context),
              ),
              subtitle: Text(
                request.address,
                style: AppTextStyle.font14RegularDarkGray(context),
              ),
              onTap: () {
                // Handle tap
                context.push(
                  Routes.accessRecordView,
                  extra: AccessRecordModel(
                    patientId: request.userId,
                    patientName: request.name,
                    patientImage: request.image,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
