import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:canc_app/users/patient/home/data/models/pharmacy_model.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/location_error.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/pharmacy_map.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/pharmacy_info_card.dart';

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
  bool _hasLocationError = false;
  String? _errorMessage;
  final PolylinePoints _polylinePoints = PolylinePoints();

  @override
  void initState() {
    super.initState();
    _location = Location();
    _initializeLocation();
  }

  Future<bool> _requestLocationPermissions() async {
    try {
      final status = await Permission.location.request();
      if (status.isGranted) return true;

      if (status.isPermanentlyDenied && mounted) {
        _showPermissionSettingsDialog();
      }
      return false;
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasLocationError = true;
          _errorMessage = S.of(context).locationPermissionError;
        });
      }
      return false;
    }
  }

  void _showPermissionSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).locationAccessRequired),
        content: Text(S.of(context).locationPermissionMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: Text(S.of(context).openSettings),
          ),
        ],
      ),
    );
  }

  Future<void> _initializeLocation() async {
    try {
      setState(() {
        _isLoading = true;
        _hasLocationError = false;
        _errorMessage = null;
      });

      final hasPermission = await _requestLocationPermissions();
      if (!hasPermission) {
        setState(() {
          _isLoading = false;
          _hasLocationError = true;
          _errorMessage = S.of(context).locationPermissionError;
        });
        return;
      }

      final serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        final serviceRequested = await _location.requestService();
        if (!serviceRequested) {
          setState(() {
            _isLoading = false;
            _hasLocationError = true;
            _errorMessage = S.of(context).locationPermissionError;
          });
          return;
        }
      }

      _currentLocation = await _location.getLocation();

      _location.onLocationChanged.listen((locationData) {
        if (mounted) {
          setState(() {
            _currentLocation = locationData;
            _updateMarkersAndRoute();
          });
        }
      });

      await _updateMarkersAndRoute();

      setState(() => _isLoading = false);
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasLocationError = true;
          _errorMessage = S.of(context).locationPermissionError;
        });
      }
    }
  }

  Future<void> _updateMarkersAndRoute() async {
    if (_currentLocation == null) {
      return;
    }

    try {
      // Update markers
      _markers = {
        Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(
            _currentLocation!.latitude!,
            _currentLocation!.longitude!,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: S.of(context).yourLocation),
        ),
        Marker(
          markerId: const MarkerId('pharmacy'),
          position: LatLng(
            widget.pharmacy.latitude,
            widget.pharmacy.longitude,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: widget.pharmacy.name),
        ),
      };

      // Update route polyline
      final result = await _polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: 'AIzaSyA2krlhMupMlhllOHR03Nl8eCOW_2uAHKY',
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
        _polylines = {
          Polyline(
            polylineId: const PolylineId('route'),
            points: result.points
                .map((point) => LatLng(point.latitude, point.longitude))
                .toList(),
            color: AppColors.primaryColor,
            width: 5,
          ),
        };
      }

      if (_mapController != null && _markers.length == 2) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLngBounds(_getBoundsForMarkers(), 100.0),
        );
      }

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).locationPermissionError)),
        );
      }
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
      appBar: CustomAppBar(
        title: widget.pharmacy.name,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasLocationError || _currentLocation == null) {
      return LocationError(
        errorMessage: _errorMessage,
        onRetry: _initializeLocation,
      );
    }

    return Stack(
      children: [
        PharmacyMap(
          currentLocation: _currentLocation!,
          markers: _markers,
          polylines: _polylines,
          onMapCreated: (controller) {
            _mapController = controller;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _updateMarkersAndRoute();
            });
          },
        ),
        PharmacyInfoCard(pharmacy: widget.pharmacy),
      ],
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
