import 'dart:io';

import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/sign_up/presentation/views/widgets/photo_card.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/core/widgets/image_source_picker.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../manger/complete_doctor_registration_cubit/complete_doctor_registration_cubit.dart';
import '../../manger/complete_doctor_registration_cubit/complete_doctor_registration_state.dart';
import 'info_box.dart';

class CompleteDoctorRegistrationViewBody extends StatelessWidget {
  const CompleteDoctorRegistrationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteDoctorRegistrationCubit,
        CompleteDoctorRegistrationState>(
      listener: (context, state) async {
        if (state.uploadSuccess) {
          final userType =
              getIt<CacheHelper>().getData(key: CacheKeys.whoAreYou);
          if (userType == UsersKey.doctor) {
            context.go(Routes.doctorView);
          } else if (userType == UsersKey.psychiatrist) {
            context.go(Routes.psychiatristView);
          }
          botTextToast(S.of(context).signUpSuccessful);

          /// Save is logged in to cache
          await getIt<CacheHelper>().saveData(
            key: CacheKeys.isLoggedIn,
            value: true,
          );
        }
        if (!state.uploadSuccess) {
          botTextToast(state.errorMessage!);
        }
      },
      builder: (context, state) {
        final cubit = context.read<CompleteDoctorRegistrationCubit>();
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.screenWidth * 0.06,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: context.setMinSize(35),
                            backgroundColor:
                                AppColors.primaryColor.withAlpha(25),
                            child: Icon(
                              Icons.verified_user_outlined,
                              size: context.setMinSize(40),
                              color: AppColors.lightTeal,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            S.of(context).documentVerification,
                            style: AppTextStyle.font20SemiBold(context),
                            textAlign: TextAlign.center,
                          ),
                          const VerticalSpacer(4),
                          Text(
                            S.of(context).documentVerificationDescription,
                            style: AppTextStyle.font16RegularDarkGray(context)
                                .copyWith(
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const VerticalSpacer(8),
                    Text(
                      S.of(context).medicalSyndicateLicense,
                      style: AppTextStyle.font16RegularDarkGray(context),
                    ),
                    const VerticalSpacer(12),
                    PhotoCard(
                      imageFile: state.syndicatePhoto == null
                          ? null
                          : File(state.syndicatePhoto!.path),
                      onTap: () => _handleImagePicker(context, true),
                      placeholderIcon: Icons.badge_outlined,
                      placeholderText:
                          S.of(context).tapToTakePhotoOfYourLicense,
                      subText: S.of(context).makeSureAllTextVisible,
                    ),
                    InfoBox(
                      points: [
                        S.of(context).licenseMustBeIssuedByAuthority,
                        S.of(context).licenseMustBeValidAndNotExpired,
                        S.of(context).allPersonalDetailsMustBeVisible,
                      ],
                    ),
                    const VerticalSpacer(24),
                    Text(
                      S.of(context).governmentId,
                      style: AppTextStyle.font16RegularDarkGray(context),
                    ),
                    const VerticalSpacer(12),
                    PhotoCard(
                      imageFile: state.idPhoto == null
                          ? null
                          : File(state.idPhoto!.path),
                      onTap: () => _handleImagePicker(context, false),
                      placeholderIcon: Icons.badge_outlined,
                      placeholderText: S.of(context).tapToTakePhotoOfYourId,
                      subText: S.of(context).makeSureAllTextVisible,
                    ),
                    InfoBox(
                      points: [
                        S.of(context).idMustBeValidAndNotExpired,
                        S.of(context).bothFrontAndBackSidesRequired,
                        S.of(context).allPersonalInfoMustBeVisible,
                        S.of(context).noFingersCoveringId,
                      ],
                    ),
                    const VerticalSpacer(20),
                  ],
                ),
              ),
              const VerticalSpacer(20),
              AppButtonWidget(
                onPressed: state.canContinue && !state.isUploading
                    ? cubit.uploadDocuments
                    : () {},
                text: S.of(context).upload,
                isLoading: state.isUploading,
              )
            ],
          ),
        );
      },
    );
  }

  // Use bottom sheet to handle image source selection
  void _handleImagePicker(BuildContext context, bool isSyndicate) {
    final cubit =
        context.read<CompleteDoctorRegistrationCubit>(); // Get the Cubit

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.offWhite,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(context.setMinSize(20))),
      ),
      builder: (context) {
        return ImageSourcePicker(
          onImageSourceSelected: (source) {
            cubit.pickImage(source: source, isSyndicate: isSyndicate);
          },
        );
      },
    );
  }
}
