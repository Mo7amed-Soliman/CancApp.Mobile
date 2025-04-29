import 'package:location/location.dart';

class LocationServices {
  static final Location _location = Location();

  /// Ensures both the location service and permissions are granted.
  /// Returns `true` if location is ready to use, otherwise `false`.
  static Future<bool> ensureLocationReady() async {
    final serviceReady = await _checkAndRequestService();
    if (!serviceReady) return false;

    final permissionGranted = await _checkAndRequestPermission();
    if (!permissionGranted) return false;

    return true;
  }

  static Future<bool> _checkAndRequestService() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
    }
    return serviceEnabled;
  }

  static Future<bool> _checkAndRequestPermission() async {
    PermissionStatus permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
    }
    return permission == PermissionStatus.granted;
  }

  /// Direct access to the `location` instance for location fetching.
  static Location get instance => _location;
}
