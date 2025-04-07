import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_provider.dart';
import 'package:canc_app/users/patient/home/data/models/pharmacy_item_model.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/nearest_pharmacy_item.dart';
import 'package:flutter/material.dart';

class NearestPharmacyGrid extends StatelessWidget {
  const NearestPharmacyGrid({super.key});

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
      baseSize: const Size(250, 150),
      width: context.setWidth(300),
      height: context.setHeight(150),
      child: Builder(builder: (context) {
        return SizedBox(
          height: context.sizeProvider.height,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.2,
              mainAxisSpacing: context.setHeight(10),
              crossAxisSpacing: context.setWidth(10),
            ),
            itemCount: pharmacyItems.length,
            itemBuilder: (context, index) {
              final item = pharmacyItems[index];
              return NearestPharmacyItem(item: item);
            },
          ),
        );
      }),
    );
  }
}
