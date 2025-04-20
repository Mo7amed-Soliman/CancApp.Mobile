import 'package:flutter/foundation.dart';

class FilterState extends ChangeNotifier {
  final List<String> _selectedFilters = ['All'];
  final List<String> _availableFilters = [
    'All',
    'Delivery',
    'Open Now',
  ];

  List<String> get selectedFilters => List.unmodifiable(_selectedFilters);
  List<String> get availableFilters => _availableFilters;

  void toggleFilter(String filter) {
    if (filter == 'All') {
      _selectedFilters.clear();
      _selectedFilters.add('All');
    } else {
      _selectedFilters.remove('All');
      if (_selectedFilters.contains(filter)) {
        _selectedFilters.remove(filter);
        if (_selectedFilters.isEmpty) {
          _selectedFilters.add('All');
        }
      } else {
        if (_selectedFilters.length < 3) {
          _selectedFilters.add(filter);
        }
      }
    }
    notifyListeners();
  }

  bool isFilterSelected(String filter) {
    return _selectedFilters.contains(filter);
  }

  bool shouldShowPharmacy(List<String> services) {
    if (_selectedFilters.contains('All')) return true;
    return _selectedFilters.any((filter) => services.contains(filter));
  }
}
