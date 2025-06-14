import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/shared_feature/edit_profile/presentation/manager/edit_profile_cubit.dart';
import 'package:canc_app/core/shared_feature/edit_profile/presentation/views/widgets/edit_profile_image.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/core/widgets/app_text_form_field.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/edit_profile_state.dart';

class EditProfileBody extends StatefulWidget {
  const EditProfileBody({super.key});

  @override
  State<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  late final TextEditingController nameController;
  late final TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: UserCacheHelper.getUser()!.name,
    );
    addressController = TextEditingController(
      text: UserCacheHelper.getUser()!.address,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          botTextToast(S.of(context).updatedSuccessfully,
              color: AppColors.primaryColor);
        } else if (state is EditProfileFailure) {
          botTextToast(state.error);
        }
      },
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is EditProfileLoading,
          child: Column(
            children: [
              const EditProfileImage(),
              const VerticalSpacer(80),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.screenWidth * 0.06,
                  ),
                  child: Column(
                    children: [
                      AppTextFormField(
                        controller: nameController,
                        label: S.of(context).fullName,
                        labelStyle: AppTextStyle.font17Medium(context),
                      ),
                      const SizedBox(height: 20),
                      AppTextFormField(
                        controller: addressController,
                        label: S.of(context).address,
                        labelStyle: AppTextStyle.font17Medium(context),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.screenWidth * 0.06,
                ),
                child: AppButtonWidget(
                  onPressed: () {
                    context.read<EditProfileCubit>().saveProfile(
                          name: nameController.text,
                          address: addressController.text,
                        );
                  },
                  text: S.of(context).save,
                  isLoading: state is EditProfileLoading,
                ),
              ),
              const VerticalSpacer(28),
            ],
          ),
        );
      },
    );
  }
}
