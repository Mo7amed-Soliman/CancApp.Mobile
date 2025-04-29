import 'dart:developer';
import 'dart:io';

import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/core/widgets/app_text_form_field.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  File? _idImage;
  File? _licenseImage;
  bool _deliveryEnabled = false;

  @override
  Widget build(BuildContext context) {
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
                UploadPhotoSection(
                  title: S.of(context).pharmacyLicenseTitle,
                  imageFile: _licenseImage,
                  onTap: () {},
                  placeholderIcon: Icons.badge_outlined,
                  placeholderText: S.of(context).tapToTakePhotoOfYourLicense,
                  subText: S.of(context).makeSureAllTextVisible,
                  infoPoints: [
                    S.of(context).licenseMustBeIssuedByAuthority,
                    S.of(context).licenseMustBeValidAndNotExpired,
                    S.of(context).allPersonalDetailsMustBeVisible,
                  ],
                ),
                const VerticalSpacer(24),
                UploadPhotoSection(
                  title: S.of(context).governmentId,
                  imageFile: _idImage,
                  onTap: () {},
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
                AppTextFormField(
                  controller: _workingHoursController,
                  label: S.of(context).dailyWorkingHoursLabel,
                  filled: true,
                  fillColor: AppColors.lightGray,
                  keyboardType: TextInputType.number,
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
                GestureDetector(
                  onTap: _pickLocation,
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
                DeliverySwitchSection(
                  deliveryEnabled: _deliveryEnabled,
                  onChanged: (value) {
                    setState(() {
                      _deliveryEnabled = value;
                    });
                  },
                ),
                const VerticalSpacer(24),
              ],
            ),
          ),
          const VerticalSpacer(20),
          AppButtonWidget(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                log('All fields valid');
                // Proceed with submission
              }
            },
            text: S.of(context).upload,
          ),
          const VerticalSpacer(20),
        ],
      ),
    );
  }

  Future<void> _pickLocation() async {
    final LatLng? result = await showDialog<LatLng>(
      context: context,
      builder: (_) => const MapDialog(),
    );
    if (result != null) {
      setState(() {
        _locationController.text = '${result.latitude}, ${result.longitude}';
      });
    }
  }
}
