import 'package:canc_app/users/patient/home/data/models/pharmacy_model.dart';
import 'package:canc_app/users/patient/home/data/repositories/nearest_pharmacy_repository.dart';
import 'package:canc_app/users/patient/home/presentation/manager/nearest_pharmacy_cubit/nearest_pharmacy_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

class NearestPharmacyCubit extends Cubit<NearestPharmacyState> {
  final NearestPharmacyRepository _repository;
  final List<NearestPharmacyModel> pharmacies = [];
  final Location _location = Location();

  NearestPharmacyCubit({required NearestPharmacyRepository repository})
      : _repository = repository,
        super(
          NearestPharmacyInitial(),
        );

  Future<void> getNearestPharmacies() async {
    emit(NearestPharmacyLoading());

    try {
      // Check if location service is enabled
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {}
      }

      // Check location permission
      PermissionStatus permission = await _location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await _location.requestPermission();
        if (permission == PermissionStatus.denied) {}
      }

      // Get current location
      final locationData = await _location.getLocation();

      final result = await _repository.getNearestPharmacies(
        latitude: locationData.latitude ?? 0,
        longitude: locationData.longitude ?? 0,
      );

      result.fold(
        (failure) {
          emit(NearestPharmacyError(failure.toString()));
        },
        (pharmacies) {
          this.pharmacies.clear();
          this.pharmacies.addAll(pharmacies);
          emit(NearestPharmacySuccess(this.pharmacies));
        },
      );
    } catch (e) {
      emit(NearestPharmacyError(e.toString()));
    }
  }
}
