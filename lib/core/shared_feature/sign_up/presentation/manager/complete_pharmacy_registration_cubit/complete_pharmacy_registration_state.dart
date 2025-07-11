part of 'complete_pharmacy_registration_cubit.dart';

class CompletePharmacyRegistrationState {
  final XFile? licensePhoto;
  final XFile? idPhoto;
  final LatLng? location;
  final String? workingHours;
  final String? openHour;
  final String? closeHour;
  final bool deliveryEnabled;
  final bool isUploading;
  final bool uploadSuccess;
  final String? errorMessage;

  const CompletePharmacyRegistrationState({
    this.licensePhoto,
    this.idPhoto,
    this.location,
    this.workingHours,
    this.openHour,
    this.closeHour,
    this.deliveryEnabled = false,
    required this.isUploading,
    required this.uploadSuccess,
    this.errorMessage,
  });

  factory CompletePharmacyRegistrationState.initial() {
    return const CompletePharmacyRegistrationState(
      deliveryEnabled: false,
      isUploading: false,
      uploadSuccess: false,
    );
  }

  bool get canContinue =>
      licensePhoto != null &&
      idPhoto != null &&
      location != null &&
      workingHours != null &&
      workingHours!.isNotEmpty &&
      openHour != null &&
      closeHour != null;

  CompletePharmacyRegistrationState copyWith({
    XFile? licensePhoto,
    XFile? idPhoto,
    LatLng? location,
    String? workingHours,
    String? openHour,
    String? closeHour,
    bool? deliveryEnabled,
    bool? isUploading,
    bool? uploadSuccess,
    String? errorMessage,
  }) {
    return CompletePharmacyRegistrationState(
      licensePhoto: licensePhoto ?? this.licensePhoto,
      idPhoto: idPhoto ?? this.idPhoto,
      location: location ?? this.location,
      workingHours: workingHours ?? this.workingHours,
      openHour: openHour ?? this.openHour,
      closeHour: closeHour ?? this.closeHour,
      deliveryEnabled: deliveryEnabled ?? this.deliveryEnabled,
      isUploading: isUploading ?? this.isUploading,
      uploadSuccess: uploadSuccess ?? this.uploadSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
