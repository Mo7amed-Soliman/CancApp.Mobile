import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/users/patient/home/data/models/access_request_model.dart';
import 'package:canc_app/users/patient/home/presentation/manager/access_request_cubit/access_request_cubit.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/access_requests_view_body.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccessRequestView extends StatelessWidget {
  const AccessRequestView({super.key, required this.pendingRequests});
  final List<AccessRequestModel> pendingRequests;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AccessRequestCubit>(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: S.of(context).accessRequests,
        ),
        body: AccessRequestsViewBody(items: pendingRequests),
      ),
    );
  }
}
