import 'dart:io';

import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/core/widgets/app_text_form_field.dart';
import 'package:canc_app/core/widgets/image_source_picker.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../manager/complete_pharmacy_registration_cubit/complete_pharmacy_registration_cubit.dart';
import 'complete_registration_header.dart';
import 'delivery_switch_section.dart';
import 'map_dialog.dart';
import 'upload_photo_section.dart';

class CompletePharmacyRegistrationViewBody extends StatefulWidget {
  const CompletePharmacyRegistrationViewBody({super.key});

  @override
  State<CompletePharmacyRegistrationViewBody> createState() =>
      _CompletePharmacyRegistrationViewBodyState();
}

class _CompletePharmacyRegistrationViewBodyState
    extends State<CompletePharmacyRegistrationViewBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _workingHoursController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _workingHoursController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompletePharmacyRegistrationCubit,
        CompletePharmacyRegistrationState>(
      listener: (BuildContext context, state) async {
        if (state.uploadSuccess) {
          if (!context.mounted) return;
          context.go(Routes.loginView);

          if (!context.mounted) return;
          botTextToast(
            S.of(context).accountReviewMessage,
            color: AppColors.darkTeal,
          );
        } else if (state.errorMessage != null) {
          if (!context.mounted) return;
          botTextToast(state.errorMessage!);
        }
      },
      builder: (BuildContext context, state) {
        final cubit = context.read<CompletePharmacyRegistrationCubit>();
        return Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CompleteRegistrationHeader(
                      title: S.of(context).pharmacyDetailsTitle,
                      description: S.of(context).pharmacyDetailsDescription,
                    ),
                    const VerticalSpacer(8),

                    /// License Image
                    UploadPhotoSection(
                      title: S.of(context).pharmacyLicenseTitle,
                      imageFile: state.licensePhoto != null
                          ? File(state.licensePhoto!.path)
                          : null,
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

                    /// ID Image
                    UploadPhotoSection(
                      title: S.of(context).governmentId,
                      imageFile: state.idPhoto != null
                          ? File(state.idPhoto!.path)
                          : null,
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

                    const VerticalSpacer(24),

                    /// Working Hours
                    AppTextFormField(
                      controller: _workingHoursController,
                      label: S.of(context).dailyWorkingHoursLabel,
                      filled: true,
                      fillColor: AppColors.lightGray,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => cubit.setWorkingHours(value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).workingHoursValidationError;
                        }
                        final hours = int.tryParse(value);
                        if (hours == null || hours > 24 || hours < 3) {
                          return S.of(context).validNumberValidationError;
                        }
                        return null;
                      },
                    ),

                    const VerticalSpacer(24),

                    /// Open Hours
                    GestureDetector(
                      onTap: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null && context.mounted) {
                          cubit.setOpenHour(pickedTime.format(context));
                        }
                      },
                      child: AbsorbPointer(
                        child: AppTextFormField(
                          label: S.of(context).openHourLabel,
                          filled: true,
                          fillColor: AppColors.lightGray,
                          controller: TextEditingController(
                            text: state.openHour,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).openHourValidationError;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),

                    const VerticalSpacer(24),

                    /// Close Hours
                    GestureDetector(
                      onTap: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null && context.mounted) {
                          cubit.setCloseHour(pickedTime.format(context));
                        }
                      },
                      child: AbsorbPointer(
                        child: AppTextFormField(
                          label: S.of(context).closeHourLabel,
                          filled: true,
                          fillColor: AppColors.lightGray,
                          controller: TextEditingController(
                            text: state.closeHour,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).closeHourValidationError;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),

                    const VerticalSpacer(24),

                    /// Location
                    GestureDetector(
                      onTap: () => _pickLocation(context),
                      child: AbsorbPointer(
                        child: AppTextFormField(
                          controller: _locationController,
                          label: S.of(context).selectLocationLabel,
                          filled: true,
                          fillColor: AppColors.lightGray,
                          enabled: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).selectLocationError;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),

                    const VerticalSpacer(24),

                    /// Delivery Switch
                    DeliverySwitchSection(
                      deliveryEnabled: state.deliveryEnabled,
                      onChanged: (value) => cubit.setDeliveryEnabled(value),
                    ),

                    const VerticalSpacer(24),
                  ],
                ),
              ),
              const VerticalSpacer(20),

              /// Upload Button
              AppButtonWidget(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    cubit.uploadDocuments();
                  }
                },
                text: S.of(context).upload,
                isLoading: state.isUploading,
              ),

              const VerticalSpacer(20),
            ],
          ),
        );
      },
    );
  }

  void _handleImagePicker(BuildContext context, bool isLicense) {
    final cubit = context.read<CompletePharmacyRegistrationCubit>();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.offWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return ImageSourcePicker(
          onImageSourceSelected: (source) {
            cubit.pickImage(source: source, isLicense: isLicense);
          },
        );
      },
    );
  }

  Future<void> _pickLocation(BuildContext context) async {
    final cubit = context.read<CompletePharmacyRegistrationCubit>();
    final LatLng? result = await showDialog<LatLng>(
      context: context,
      builder: (_) => const MapDialog(),
    );

    if (!context.mounted) return;

    if (result != null) {
      _locationController.text = '${result.latitude}, ${result.longitude}';
      cubit.setLocation(result);
    }
  }
}
