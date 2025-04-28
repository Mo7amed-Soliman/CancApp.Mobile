import 'dart:io';

import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/core/widgets/app_text_form_field.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'complete_registration_header.dart';
import 'delivery_switch_section.dart';
import 'upload_photo_section.dart';

class CompletePharmacyRegistrationViewBody extends StatefulWidget {
  const CompletePharmacyRegistrationViewBody({super.key});

  @override
  State<CompletePharmacyRegistrationViewBody> createState() =>
      _CompletePharmacyRegistrationViewBodyState();
}

class _CompletePharmacyRegistrationViewBodyState
    extends State<CompletePharmacyRegistrationViewBody> {
  //
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _workingHoursController = TextEditingController();
  File? _idImage;
  File? _licenseImage;
  bool _deliveryEnabled = true;
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
                    if (int.parse(value) <= 24 && int.parse(value) >= 3) {
                      return S.of(context).validNumberValidationError;
                    }
                    return null;
                  },
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
            onPressed: () {},
            text: S.of(context).upload,
          ),
          const VerticalSpacer(20),
        ],
      ),
    );
  }
}
