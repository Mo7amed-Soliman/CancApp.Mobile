import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:canc_app/users/patient/home/data/models/pharmacy_model.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:permission_handler/permission_handler.dart';

class PharmacyNavigationView extends StatefulWidget {
  final NearestPharmacyModel pharmacy;

  const PharmacyNavigationView({
    super.key,
    required this.pharmacy,
  });

  @override
  State<PharmacyNavigationView> createState() => _PharmacyNavigationViewState();
}

class _PharmacyNavigationViewState extends State<PharmacyNavigationView> {
  GoogleMapController? _mapController;
  late Location _location;
  LocationData? _currentLocation;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  bool _isLoading = true;
  final PolylinePoints _polylinePoints = PolylinePoints();

  @override
  void initState() {
    super.initState();
    _location = Location();
    _initializeLocation();
  }

  Future<bool> _requestLocationPermissions() async {
    final foregroundStatus = await Permission.location.request();

    if (foregroundStatus.isGranted) {
      final backgroundStatus = await Permission.locationAlways.request();
      if (backgroundStatus.isGranted) {
        return true;
      } else if (backgroundStatus.isPermanentlyDenied && mounted) {
        _showPermissionSettingsDialog();
      }
    } else if (foregroundStatus.isPermanentlyDenied && mounted) {
      _showPermissionSettingsDialog();
    }

    return false;
  }

  void _showPermissionSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Required'),
        content: const Text(
          'This app needs location permission to show your route to the pharmacy. '
          'Please enable location permission in app settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  Future<void> _initializeLocation() async {
    try {
      setState(() => _isLoading = true);

      final hasPermission = await _requestLocationPermissions();
      if (!hasPermission) {
        // setState(() => _isLoading = false);
        // return;
      }

      // Check if service is enabled
      final serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        final serviceRequested = await _location.requestService();
        if (!serviceRequested) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Location services are disabled.'),
              ),
            );
          }
          // setState(() => _isLoading = false);
          // return;
        }
      }

      // Get current location
      _currentLocation = await _location.getLocation();
      log('currentLocation: ${_currentLocation?.latitude}');
      log('currentLocation: ${_currentLocation?.longitude}');
      // try {
      //   await _location.enableBackgroundMode(enable: true);
      // } catch (e) {
      //   debugPrint('Background mode error: $e');
      // }

      // _location.onLocationChanged.listen(
      //   (locationData) {
      //     if (mounted) {
      //       setState(() {
      //         _currentLocation = locationData;
      //         _updateMarkersAndRoute();
      //       });
      //     }
      //   },
      // );

      setState(() {
        _isLoading = false;
      });

      _updateMarkersAndRoute();
    } catch (e) {
      debugPrint('Error initializing location: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _currentLocation = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error initializing location: $e')),
        );
      }
    }
  }

  Future<void> _updateMarkersAndRoute() async {
    if (_currentLocation == null) {
      debugPrint('Current location is null.');
      return;
    }

    _markers = {
      Marker(
        markerId: const MarkerId('current_location'),
        position:
            LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: 'Your Location'),
      ),
      Marker(
        markerId: const MarkerId('pharmacy'),
        position: LatLng(widget.pharmacy.latitude, widget.pharmacy.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: widget.pharmacy.name),
      ),
    };

    try {
      final result = await _polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: 'AIzaSyCvdP-4WbB5pNQZqWT24ymlKZTE5Hru6AY',
        request: PolylineRequest(
          origin: PointLatLng(
            _currentLocation!.latitude!,
            _currentLocation!.longitude!,
          ),
          destination: PointLatLng(
            widget.pharmacy.latitude,
            widget.pharmacy.longitude,
          ),
          mode: TravelMode.driving,
        ),
      );

      if (result.points.isNotEmpty) {
        final polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();

        _polylines = {
          Polyline(
            polylineId: const PolylineId('route'),
            points: polylineCoordinates,
            color: AppColors.primaryColor,
            width: 5,
          ),
        };
      } else {
        debugPrint('Polyline result empty.');
      }
    } catch (e) {
      debugPrint('Error getting route: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error getting route: $e')),
        );
      }
    }

    if (_mapController != null && _markers.length == 2) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(_getBoundsForMarkers(), 50.0),
      );
    }
  }

  LatLngBounds _getBoundsForMarkers() {
    final points = _markers.map((m) => m.position).toList();
    return LatLngBounds(
      southwest: LatLng(
        points.map((p) => p.latitude).reduce((a, b) => a < b ? a : b),
        points.map((p) => p.longitude).reduce((a, b) => a < b ? a : b),
      ),
      northeast: LatLng(
        points.map((p) => p.latitude).reduce((a, b) => a > b ? a : b),
        points.map((p) => p.longitude).reduce((a, b) => a > b ? a : b),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pharmacy.name),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _currentLocation == null
              ? _buildLocationErrorView(context)
              : Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          _currentLocation!.latitude!,
                          _currentLocation!.longitude!,
                        ),
                        zoom: 16,
                      ),
                      onMapCreated: (controller) {
                        _mapController = controller;
                        _updateMarkersAndRoute();
                      },
                      markers: _markers,
                      polylines: _polylines,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: true,
                      mapToolbarEnabled: true,
                    ),
                    _buildPharmacyCard(context),
                  ],
                ),
    );
  }

  Widget _buildLocationErrorView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off_rounded,
              size: 64,
              color: AppColors.primaryColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'Location Access Required',
              style: AppTextStyle.font17Medium(context).copyWith(
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'We need access to your location to show you the route to the pharmacy. Please enable location services in your device settings.',
              style: AppTextStyle.font14RegularDarkGray(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _initializeLocation,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: openAppSettings,
                  icon: const Icon(Icons.settings_rounded),
                  label: const Text('Open Settings'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    side: const BorderSide(color: AppColors.primaryColor),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPharmacyCard(BuildContext context) {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.pharmacy.name,
                style: AppTextStyle.font17Medium(context),
              ),
              const SizedBox(height: 8),
              Text(
                widget.pharmacy.address,
                style: AppTextStyle.font14RegularDarkGray(context),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: widget.pharmacy.isOpeningNow
                        ? AppColors.mintGreen
                        : AppColors.red,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.pharmacy.isOpeningNow
                        ? 'Open Now'
                        : S.of(context).closed,
                    style: AppTextStyle.font12MediumDarkGray(context).copyWith(
                      color: widget.pharmacy.isOpeningNow
                          ? AppColors.mintGreen
                          : AppColors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
