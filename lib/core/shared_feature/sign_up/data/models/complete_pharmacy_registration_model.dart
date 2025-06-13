import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class CompletePharmacyModel {
  String numberOfWorkingHours;
  bool isDeliveryEnabled;
  LatLng location;
  XFile idPhoto;
  XFile pharmacyLicensePhoto;
  String closeHour;
  String openHour;

  CompletePharmacyModel({
    required this.numberOfWorkingHours,
    required this.isDeliveryEnabled,
    required this.location,
    required this.idPhoto,
    required this.pharmacyLicensePhoto,
    required this.closeHour,
    required this.openHour,
  });
}
