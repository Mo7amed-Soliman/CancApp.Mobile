import 'package:flutter/foundation.dart';
import 'pharmacy_model.dart';

enum PharmacyFilter {
  all,
  delivery,
  openNow;

  String get displayName {
    switch (this) {
      case PharmacyFilter.all:
        return 'All';
      case PharmacyFilter.delivery:
        return 'Delivery';
      case PharmacyFilter.openNow:
        return 'Open Now';
    }
  }
}

class FilterState extends ChangeNotifier {
  final Set<PharmacyFilter> _selectedFilters = {PharmacyFilter.all};

  Set<PharmacyFilter> get selectedFilters => Set.unmodifiable(_selectedFilters);
  List<PharmacyFilter> get availableFilters => PharmacyFilter.values;

  void toggleFilter(PharmacyFilter filter) {
    if (filter == PharmacyFilter.all) {
      _selectedFilters.clear();
      _selectedFilters.add(PharmacyFilter.all);
    } else {
      _selectedFilters.remove(PharmacyFilter.all);
      if (_selectedFilters.contains(filter)) {
        _selectedFilters.remove(filter);
        if (_selectedFilters.isEmpty) {
          _selectedFilters.add(PharmacyFilter.all);
        }
      } else {
        if (_selectedFilters.length < 3) {
          _selectedFilters.add(filter);
        }
      }
    }
    notifyListeners();
  }

  bool isFilterSelected(PharmacyFilter filter) {
    return _selectedFilters.contains(filter);
  }

  bool shouldShowPharmacy(NearestPharmacyModel pharmacy) {
    if (_selectedFilters.contains(PharmacyFilter.all)) return true;

    return _selectedFilters.every((filter) {
      switch (filter) {
        case PharmacyFilter.delivery:
          return pharmacy.isDeliveryEnabled;
        case PharmacyFilter.openNow:
          return pharmacy.isOpeningNow;
        case PharmacyFilter.all:
          return true;
      }
    });
  }
}
