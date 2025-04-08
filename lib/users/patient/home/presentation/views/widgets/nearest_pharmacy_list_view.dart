import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_provider.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/users/patient/home/data/models/pharmacy_item_model.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/nearest_pharmacy_item.dart';
import 'package:flutter/material.dart';

class NearestPharmacyListView extends StatelessWidget {
  const NearestPharmacyListView({super.key});

  /// Creates the list of pharmacy items
  List<PharmacyItemModel> _createPharmacyItems() {
    return [
      const PharmacyItemModel(
        image: 'assets/images/dummy_image/life_line_img.png',
        name: 'Life line',
      ),
      const PharmacyItemModel(
        image: 'assets/images/dummy_image/at_home_img.png',
        name: 'At Home',
      ),
      const PharmacyItemModel(
        image: 'assets/images/dummy_image/at_home_medical_img.png',
        name: 'At Home Medical',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pharmacyItems = _createPharmacyItems();

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
              itemCount: pharmacyItems.length,
              separatorBuilder: (context, index) {
                return const HorizontalSpacer(10);
              },
              itemBuilder: (context, index) {
                final item = pharmacyItems[index];
                return SizedBox(
                  width: context.setWidth(130),
                  child: NearestPharmacyItem(item: item),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
