import 'package:canc_app/users/patient/home/data/models/pharmacy_model.dart';
import 'package:canc_app/users/patient/home/data/repositories/nearest_pharmacy_repository.dart';
import 'package:canc_app/users/patient/home/presentation/manager/nearest_pharmacy_cubit/nearest_pharmacy_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearestPharmacyCubit extends Cubit<NearestPharmacyState> {
  final NearestPharmacyRepository _repository;
  final List<Pharmacy> pharmacies = [];
  NearestPharmacyCubit({required NearestPharmacyRepository repository})
      : _repository = repository,
        super(
          NearestPharmacyInitial(),
        );

  Future<void> getNearestPharmacies() async {
    emit(NearestPharmacyLoading());

    final result = await _repository.getNearestPharmacies();

    result.fold(
      (failure) {
        emit(NearestPharmacyError(failure.toString()));
      },
      (pharmacies) {
        this.pharmacies.addAll(pharmacies);
        emit(NearestPharmacySuccess(this.pharmacies));
      },
    );
  }
}
