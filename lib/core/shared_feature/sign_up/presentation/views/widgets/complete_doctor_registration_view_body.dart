import 'dart:io';

import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/core/widgets/image_source_picker.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../manger/complete_doctor_registration_cubit/complete_doctor_registration_cubit.dart';
import '../../manger/complete_doctor_registration_cubit/complete_doctor_registration_state.dart';
import 'complete_registration_header.dart';
import 'upload_photo_section.dart';

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
            context.go(Routes.loginView);
          } else if (userType == UsersKey.psychiatrist) {
            context.go(Routes.loginView);
          }
          botTextToast(
            S.of(context).accountReviewMessage,
            color: AppColors.darkTeal,
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
                    CompleteRegistrationHeader(
                      title: S.of(context).documentVerification,
                      description:
                          S.of(context).documentVerificationDescription,
                    ),
                    const VerticalSpacer(8),

                    /// Medical Syndicate License Upload Section
                    UploadPhotoSection(
                      title: S.of(context).medicalSyndicateLicense,
                      imageFile: state.syndicatePhoto == null
                          ? null
                          : File(state.syndicatePhoto!.path),
                      onTap: () => _handleImagePicker(context, true),
                      placeholderIcon: Icons.badge_outlined,
                      placeholderText:
                          S.of(context).tapToTakePhotoOfYourLicense,
                      subText: S.of(context).makeSureAllTextVisible,
                      infoPoints: [
                        S.of(context).licenseMustBeIssuedByAuthority,
                        S.of(context).licenseMustBeValidAndNotExpired,
                        S.of(context).allPersonalDetailsMustBeVisible,
                      ],
                    ),
                    const VerticalSpacer(24),

                    /// Government ID Upload Section
                    UploadPhotoSection(
                      title: S.of(context).governmentId,
                      imageFile: state.idPhoto == null
                          ? null
                          : File(state.idPhoto!.path),
                      onTap: () => _handleImagePicker(context, false),
                      placeholderIcon: Icons.badge_outlined,
                      placeholderText: S.of(context).tapToTakePhotoOfYourId,
                      subText: S.of(context).makeSureAllTextVisible,
                      infoPoints: [
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
