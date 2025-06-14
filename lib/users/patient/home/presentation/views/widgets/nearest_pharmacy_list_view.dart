import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_provider.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/theming/font_weight_helper.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/users/patient/home/data/models/pharmacy_model.dart';
import 'package:canc_app/users/patient/home/presentation/manager/nearest_pharmacy_cubit/nearest_pharmacy_cubit.dart';
import 'package:canc_app/users/patient/home/presentation/manager/nearest_pharmacy_cubit/nearest_pharmacy_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redacted/redacted.dart';

class NearestPharmacyListView extends StatelessWidget {
  const NearestPharmacyListView({super.key});

  @override
  Widget build(BuildContext context) {
    final pharmacy = NearestPharmacyModel(
      name: '',
      image: '',
      isDeliveryEnabled: false,
      isOpeningNow: false,
      latitude: 0,
      longitude: 0,
      address: '',
    );

    return BlocBuilder<NearestPharmacyCubit, NearestPharmacyState>(
        builder: (context, state) {
      if (state is NearestPharmacyError) {
        botTextToast(state.message);
      }

      return SizeProvider(
        baseSize: const Size(250, 160),
        width: context.setWidth(300),
        height: context.setHeight(160),
        child: Builder(
          builder: (context) {
            return SizedBox(
              height: context.sizeProvider.height,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state is NearestPharmacySuccess
                    ? state.pharmacies.length
                    : 5,
                separatorBuilder: (context, index) {
                  return const HorizontalSpacer(10);
                },
                itemBuilder: (context, index) {
                  final item = state is NearestPharmacySuccess
                      ? state.pharmacies[index]
                      : null;
                  return SizedBox(
                    width: context.setWidth(145),
                    child: item != null
                        ? _NearestPharmacyItem(
                            item: item,
                          )
                        : _NearestPharmacyItem(
                            item: pharmacy,
                          ).redacted(
                            context: context,
                            redact: state is NearestPharmacyLoading,
                            configuration: RedactedConfiguration(
                              autoFillText: 'Pharmacy Name',
                            ),
                          ),
                  );
                },
              ),
            );
          },
        ),
      );
    });
  }
}

class _NearestPharmacyItem extends StatelessWidget {
  const _NearestPharmacyItem({required this.item});

  final NearestPharmacyModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: context.sizeProvider.height * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: item.image.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.local_pharmacy_outlined,
                            size: 40,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  )
                : const Center(
                    child: Icon(
                      Icons.local_pharmacy_outlined,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
          ),
          const VerticalSpacer(6),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  item.name,
                  style: AppTextStyle.font14RegularDarkGray(context).copyWith(
                    fontWeight: FontWeightHelper.medium,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
