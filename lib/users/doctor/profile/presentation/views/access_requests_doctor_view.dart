import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/doctor/profile/presentation/manager/access_requests_doctor_cubit.dart';
import 'package:canc_app/users/doctor/profile/presentation/manager/access_requests_doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/accepted_request_list.dart';
import 'widgets/send_request_list.dart';

class AccessRequestsDoctorView extends StatelessWidget {
  const AccessRequestsDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AccessRequestsDoctorCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        appBar: CustomAppBar(
          title: S.of(context).patientAccessRequests,
        ),
        body: const AccessRequestsDoctorViewBody(),
      ),
    );
  }
}

class AccessRequestsDoctorViewBody extends StatefulWidget {
  const AccessRequestsDoctorViewBody({
    super.key,
  });

  @override
  State<AccessRequestsDoctorViewBody> createState() =>
      _AccessRequestsDoctorViewBodyState();
}

class _AccessRequestsDoctorViewBodyState
    extends State<AccessRequestsDoctorViewBody> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<AccessRequestsDoctorCubit>().loadAccessRequests();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccessRequestsDoctorCubit, AccessRequestsDoctorState>(
      listener: (context, state) {
        if (state is AccessRequestsDoctorError) {
          botTextToast(state.message);
        }
      },
      builder: (context, state) {
        if (state is AccessRequestsDoctorLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AccessRequestsDoctorLoaded) {
          return Column(
            children: [
              Container(
                color: AppColors.primaryColor,
                child: TabBar(
                  controller: _tabController,
                  labelStyle: AppTextStyle.font17Medium(context),
                  unselectedLabelStyle: AppTextStyle.font17Medium(context),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: AppColors.offWhite,
                  labelColor: AppColors.offWhite,
                  unselectedLabelColor:
                      AppColors.offWhite.withValues(alpha: 0.75),
                  tabs: [
                    Tab(text: S.of(context).sendRequest),
                    Tab(text: S.of(context).acceptedRequests),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    (state.sendRequests != null)
                        ? SendRequestList(sendRequests: state.sendRequests!)
                        : const Center(
                            child: Text('No send requests'),
                          ),
                    (state.acceptedRequests != null)
                        ? AcceptedRequestList(
                            acceptedRequests: state.acceptedRequests!)
                        : const Center(
                            child: Text('No accepted requests'),
                          ),
                  ],
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
