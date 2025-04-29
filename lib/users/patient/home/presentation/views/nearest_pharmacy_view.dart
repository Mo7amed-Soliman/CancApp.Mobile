import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../data/models/filter_state.dart';
import '../../data/models/models.dart';
import 'widgets/filter_chips.dart';
import 'widgets/map_view.dart';
import 'widgets/pharmacy_sliver_list.dart';
import 'widgets/search_bar.dart';

class NearestPharmacyView extends StatefulWidget {
  final List<Pharmacy> pharmacies;
  const NearestPharmacyView({super.key, required this.pharmacies});

  @override
  State<NearestPharmacyView> createState() => _NearestPharmacyViewState();
}

class _NearestPharmacyViewState extends State<NearestPharmacyView> {
  final _filterState = FilterState();

  @override
  void dispose() {
    _filterState.dispose();
    super.dispose();
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
                const CustomSearchBar(),
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
            pharmacies: widget.pharmacies,
          ),
        ],
      ),
    );
  }
}
