import 'package:flutter/material.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationError extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onRetry;

  const LocationError({
    super.key,
    this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
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
              S.of(context).locationAccessRequired,
              style: AppTextStyle.font17Medium(context).copyWith(
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage ?? S.of(context).locationPermissionMessage,
              style: AppTextStyle.font14RegularDarkGray(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            LocationErrorActions(
              onRetry: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}

class LocationErrorActions extends StatelessWidget {
  final VoidCallback onRetry;

  const LocationErrorActions({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh_rounded),
          label: Text(S.of(context).retry),
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
          label: Text(S.of(context).openSettings),
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
    );
  }
}
