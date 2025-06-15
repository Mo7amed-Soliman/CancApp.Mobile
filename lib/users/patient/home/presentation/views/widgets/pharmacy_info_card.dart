import 'package:flutter/material.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/home/data/models/pharmacy_model.dart';

class PharmacyInfoCard extends StatelessWidget {
  final NearestPharmacyModel pharmacy;

  const PharmacyInfoCard({
    super.key,
    required this.pharmacy,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pharmacy.name,
                style: AppTextStyle.font17Medium(context),
              ),
              const SizedBox(height: 8),
              Text(
                pharmacy.address,
                style: AppTextStyle.font14RegularDarkGray(context),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: pharmacy.isOpeningNow
                        ? AppColors.mintGreen
                        : AppColors.red,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    pharmacy.isOpeningNow
                        ? S.of(context).openNow
                        : S.of(context).closed,
                    style: AppTextStyle.font12MediumDarkGray(context).copyWith(
                      color: pharmacy.isOpeningNow
                          ? AppColors.mintGreen
                          : AppColors.red,
                    ),
                  ),
                  const Spacer(),
                  if (pharmacy.latitude == 0 && pharmacy.longitude == 0)
                    Text(
                      '${pharmacy.latitude.toStringAsFixed(1)} ${S.of(context).km}',
                      style: AppTextStyle.font12MediumDarkGray(context),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
