import 'package:location/location.dart';

class LocationServices {
  //1- inquire about Location service
  //2- request permission
  //3- get Location

  static Location location = Location();
  static Future<void> checkAndRequestLocationService() async {
    bool isServiceEnabled = await location.serviceEnabled();

    if (!isServiceEnabled) {
      bool isServiceEnabled = await location.requestService();

      if (!isServiceEnabled) {
        //todo: Show error bar
      }
    }
  }

  static Future<void> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();

      if (permissionStatus != PermissionStatus.granted) {
        //todo: Show error bar
      }
    }
  }

  static Future<void> ensureLocationReady() async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
  }
}
