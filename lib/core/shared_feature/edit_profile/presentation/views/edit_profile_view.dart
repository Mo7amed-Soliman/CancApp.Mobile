import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/shared_feature/edit_profile/data/repositories/edit_profile_repository_impl.dart';
import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/edit_profile_cubit.dart';
import 'widgets/edit_profile_body.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(
        editProfileRepository: getIt<EditProfileRepository>(),
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          title: S.of(context).editProfile,
        ),
        body: const EditProfileBody(),
      ),
    );
  }
}
