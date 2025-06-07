import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/shared_feature/community/presentation/manger/community_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/community_header.dart';
import 'widgets/list_view_of_posts.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CommunityCubit>(),
      child: const SafeArea(
        child: Column(
          children: [
            CommunityHeader(),
            ListOfPosts(),
          ],
        ),
      ),
    );
  }
}
