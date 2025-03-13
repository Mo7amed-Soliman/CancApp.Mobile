import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/app_assets.dart';
import 'package:canc_app/core/shared_feature/onboarding/data/models/user_role_model.dart';
import 'package:canc_app/core/shared_feature/who/presentation/widgets/user_role_buttom.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class UserRoleSelectionWidget extends StatelessWidget {
  final String selectedRoleKey;
  final ValueChanged<String> onRoleSelected;

  const UserRoleSelectionWidget({
    super.key,
    required this.selectedRoleKey,
    required this.onRoleSelected,
  });
  @override
  Widget build(BuildContext context) {
    final roles = _initializeRoles(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.screenWidth * 0.06,
        vertical: context.screenHeight * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).selectWhoAreYou,
            style: AppTextStyle.font24SemiBoldDarkGray(context).copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: context.setHeight(24)),
          Expanded(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: roles.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final role = roles[index];
                return UserRoleButton(
                  role: role,
                  isSelected: selectedRoleKey == role.key,
                  onTap: () => onRoleSelected(role.key),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<UserRoleModel> _initializeRoles(BuildContext context) {
    return [
      UserRoleModel(
        key: 'doctor',
        title: S.of(context).doctor,
        imagePath: AppAssets.doctorIcon,
        color: AppColors.deepBlue,
      ),
      UserRoleModel(
        key: 'pharmacist',
        title: S.of(context).pharmacist,
        imagePath: AppAssets.pharmacistIcon,
        color: AppColors.mintGreen,
      ),
      UserRoleModel(
        key: 'psychiatrist',
        title: S.of(context).psychiatrist,
        imagePath: AppAssets.psychiatristIcon,
        color: AppColors.orange,
      ),
      UserRoleModel(
        key: 'volunteer',
        title: S.of(context).volunteer,
        imagePath: AppAssets.volunteerIcon,
        color: AppColors.red,
      ),
      UserRoleModel(
        key: 'patient',
        title: S.of(context).patient,
        imagePath: AppAssets.patientIcon,
        color: AppColors.purple,
      ),
    ];
  }
}
