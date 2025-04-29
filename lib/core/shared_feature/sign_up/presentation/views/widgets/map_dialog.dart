import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/services/location_services.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';

class MapDialog extends StatefulWidget {
  const MapDialog({super.key});

  @override
  State<MapDialog> createState() => _MapDialogState();
}

class _MapDialogState extends State<MapDialog> {
  LatLng? _currentPosition;
  LatLng? _pickedPosition;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  //! Fetch location and handle permission errors
  Future<void> _getLocation() async {
    final isReady = await LocationServices.ensureLocationReady();
    if (!isReady) {
      if (mounted) {
        botTextToast(S.of(context).locationPermissionError);
      }
      return;
    }

    final locData = await LocationServices.instance.getLocation();
    setState(() {
      _currentPosition = LatLng(locData.latitude!, locData.longitude!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            // Dialog Header
            const _DialogHeader(),
            // Map Body
            Expanded(
              child: _currentPosition == null
                  ? const Center(child: CircularProgressIndicator())
                  : _MapBody(
                      currentPosition: _currentPosition!,
                      pickedPosition: _pickedPosition,
                      onPositionPicked: (LatLng position) {
                        setState(() {
                          _pickedPosition = position;
                        });
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class _DialogHeader extends StatelessWidget {
  const _DialogHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Text(
              S.of(context).pickPharmacyLocation,
              style: AppTextStyle.font18SemiBoldDarkGray(context)
                  .copyWith(color: AppColors.offWhite),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _MapBody extends StatelessWidget {
  final LatLng currentPosition;
  final LatLng? pickedPosition;
  final Function(LatLng) onPositionPicked;

  const _MapBody({
    required this.currentPosition,
    required this.pickedPosition,
    required this.onPositionPicked,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      child: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentPosition,
                zoom: 16,
              ),
              mapType: MapType.hybrid,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onTap: onPositionPicked,
              markers: {
                if (pickedPosition != null)
                  Marker(
                    markerId: const MarkerId('picked'),
                    position: pickedPosition!,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                  ),
              },
            ),
          ),
          _SelectLocationButton(
              onPressed: pickedPosition != null
                  ? () => Navigator.of(context).pop(pickedPosition)
                  : null),
        ],
      ),
    );
  }
}

class _SelectLocationButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _SelectLocationButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
        ),
        onPressed: onPressed,
        child: Text(
          S.of(context).selectThisLocation,
          style: AppTextStyle.font16SemiBoldWhite(context)
              .copyWith(color: AppColors.offWhite),
        ),
      ),
    );
  }
}
