import 'package:canc_app/users/patient/home/data/models/pharmacy_model.dart';
import 'package:equatable/equatable.dart';

abstract class NearestPharmacyState extends Equatable {
  const NearestPharmacyState();

  @override
  List<Object?> get props => [];
}

class NearestPharmacyInitial extends NearestPharmacyState {}

class NearestPharmacyLoading extends NearestPharmacyState {}

class NearestPharmacySuccess extends NearestPharmacyState {
  final List<Pharmacy> pharmacies;

  const NearestPharmacySuccess(this.pharmacies);

  @override
  List<Object?> get props => [pharmacies];
}

class NearestPharmacyError extends NearestPharmacyState {
  final String message;

  const NearestPharmacyError(this.message);

  @override
  List<Object?> get props => [message];
}
