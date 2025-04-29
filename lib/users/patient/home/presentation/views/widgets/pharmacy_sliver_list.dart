import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/core/widgets/in_empty_list.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/home/data/models/filter_state.dart';
import 'package:canc_app/users/patient/home/data/models/pharmacy_model.dart';
import 'package:flutter/material.dart';

class PharmacySliverList extends StatelessWidget {
  final FilterState filterState;
  final List<Pharmacy> pharmacies;

  const PharmacySliverList({
    super.key,
    required this.filterState,
    required this.pharmacies,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: ListenableBuilder(
        listenable: filterState,
        builder: (context, _) {
          final filteredPharmacies = pharmacies.where((pharmacy) {
            if (filterState.selectedFilters.contains(PharmacyFilter.all)) {
              return true;
            }

            // If both "Open Now" and "Delivery" are selected, only show open pharmacies
            if (filterState.selectedFilters.contains(PharmacyFilter.openNow) &&
                filterState.selectedFilters.contains(PharmacyFilter.delivery)) {
              if (!pharmacy.isOpen) {
                return false;
              }
            }

            return filterState.selectedFilters.any((filter) {
              switch (filter) {
                case PharmacyFilter.delivery:
                  return pharmacy.isDelivery;
                case PharmacyFilter.openNow:
                  return pharmacy.isOpen;
                default:
                  return true;
              }
            });
          }).toList();

          if (filteredPharmacies.isEmpty) {
            return SliverToBoxAdapter(
              child: InEmptyList(
                title: S.of(context).noPharmaciesFound,
              ),
            );
          }

          return SliverList.builder(
            itemBuilder: (context, index) {
              final pharmacy = filteredPharmacies[index];
              return _PharmacyCard(pharmacy: pharmacy);
            },
            itemCount: filteredPharmacies.length,
          );
        },
      ),
    );
  }
}

class _PharmacyCard extends StatelessWidget {
  final Pharmacy pharmacy;

  const _PharmacyCard({
    required this.pharmacy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: context.setHeight(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                pharmacy.imageUrl,
                width: context.setMinSize(82),
                height: context.setMinSize(90),
                fit: BoxFit.cover,
              ),
            ),
            const HorizontalSpacer(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pharmacy.name,
                        style: AppTextStyle.font17Medium(context),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: context.setMinSize(16),
                            color: pharmacy.isOpen
                                ? AppColors.mintGreen
                                : AppColors.red,
                          ),
                          const HorizontalSpacer(4),
                          Text(
                            pharmacy.isOpen
                                ? pharmacy.openUntil
                                : S.of(context).closed,
                            style: AppTextStyle.font12MediumDarkGray(context)
                                .copyWith(
                              color: pharmacy.isOpen
                                  ? AppColors.mintGreen
                                  : AppColors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const VerticalSpacer(4),
                  Text(
                    pharmacy.address,
                    style: AppTextStyle.font12MediumDarkGray(context).copyWith(
                      color: AppColors.grayish,
                    ),
                  ),
                  const VerticalSpacer(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: pharmacy.isOpen ? () {} : null,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: pharmacy.isOpen
                              ? AppColors.primaryColor
                              : AppColors.grayish,
                          side: BorderSide(
                            color: pharmacy.isOpen
                                ? AppColors.primaryColor
                                : AppColors.grayish,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9999),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: pharmacy.isOpen
                                  ? AppColors.primaryColor
                                  : AppColors.grayish,
                            ),
                            const HorizontalSpacer(4),
                            Text(
                              S.of(context).navigate,
                              style: AppTextStyle.font14RegularDarkGray(context)
                                  .copyWith(
                                color: pharmacy.isOpen
                                    ? AppColors.primaryColor
                                    : AppColors.grayish,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
