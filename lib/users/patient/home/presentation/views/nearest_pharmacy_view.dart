import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/core/widgets/custom_text_field.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../data/models/filter_state.dart';
import '../../data/models/models.dart';
import 'widgets/filter_chips.dart';
import 'widgets/map_view.dart';
import 'widgets/pharmacy_sliver_list.dart';

class NearestPharmacyView extends StatefulWidget {
  final List<NearestPharmacyModel> pharmacies;
  const NearestPharmacyView({super.key, required this.pharmacies});

  @override
  State<NearestPharmacyView> createState() => _NearestPharmacyViewState();
}

class _NearestPharmacyViewState extends State<NearestPharmacyView> {
  final _filterState = FilterState();
  final _searchController = TextEditingController();
  List<NearestPharmacyModel> _filteredPharmacies = [];

  @override
  void initState() {
    super.initState();
    _filteredPharmacies = widget.pharmacies;
  }

  @override
  void dispose() {
    _filterState.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterPharmacies(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredPharmacies = widget.pharmacies;
      } else {
        _filteredPharmacies = widget.pharmacies.where((pharmacy) {
          return pharmacy.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).nearestPharmacy,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const VerticalSpacer(8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextField(
                    controller: _searchController,
                    hintText: S.of(context).search,
                    hintColor: AppColors.grayish,
                    textColor: AppColors.grayish,
                    fillColor: AppColors.lightGray,
                    filled: true,
                    prefixIcon: const Icon(
                      IconlyLight.search,
                      color: AppColors.grayish,
                    ),
                    onChanged: _filterPharmacies,
                  ),
                ),
                const VerticalSpacer(16),
                const MapView(),
                const VerticalSpacer(16),
                FilterChips(filterState: _filterState),
                const VerticalSpacer(16),
              ],
            ),
          ),
          PharmacySliverList(
            filterState: _filterState,
            pharmacies: _filteredPharmacies,
          ),
        ],
      ),
    );
  }
}
