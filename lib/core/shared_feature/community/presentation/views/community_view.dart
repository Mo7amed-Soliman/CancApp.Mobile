import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/shared_feature/community/manager/community_cubit.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/cummunity_view_body.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CommunityCubit>()..loadPosts(),
      child:const Scaffold(
        backgroundColor: AppColors.offWhite,
        body: CummunityViewBody(),
      ),
    );
  }
}
