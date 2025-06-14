import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/in_empty_list.dart';
import 'package:canc_app/users/doctor/profile/data/model/access_request_doctor_model.dart';
import 'package:canc_app/users/doctor/profile/presentation/manager/access_requests_doctor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class SendRequestList extends StatelessWidget {
  const SendRequestList({super.key, required this.sendRequests});
  final List<AccessRequestDoctorModel> sendRequests;

  @override
  Widget build(BuildContext context) {
    return sendRequests.isEmpty
        ? const InEmptyList(title: 'No Patient Available')
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 5),
            itemCount: sendRequests.length,
            itemBuilder: (context, index) {
              final request = sendRequests[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 0,
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
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
                    trailing: IconButton(
                      icon: const Icon(
                        IconlyBold.send,
                        size: 30,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        if (UserCacheHelper.getUser()?.id == null) {
                          return;
                        }
                        context.read<AccessRequestsDoctorCubit>().sendAccess(
                              patientId: request.userId,
                              doctorId: UserCacheHelper.getUser()!.id,
                            );
                      },
                    ),
                  ),
                ),
              );
            },
          );
  }
}
