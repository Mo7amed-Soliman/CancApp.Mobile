import 'package:canc_app/core/shared_feature/sign_up/data/models/complete_pharmacy_registration_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/repositories/sign_up_repository.dart';

part 'complete_pharmacy_registration_state.dart';

class CompletePharmacyRegistrationCubit
    extends Cubit<CompletePharmacyRegistrationState> {
  final ImagePicker _picker = ImagePicker();
  final SignUpRepository _signUpRepository;

  CompletePharmacyRegistrationCubit({
    required SignUpRepository signUpRepository,
  })  : _signUpRepository = signUpRepository,
        super(CompletePharmacyRegistrationState.initial());

  Future<void> pickImage({
    required ImageSource source,
    required bool isLicense,
  }) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (pickedFile != null) {
        isLicense
            ? emit(state.copyWith(licensePhoto: pickedFile))
            : emit(state.copyWith(idPhoto: pickedFile));
      }
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to pick image: ${e.toString()}',
      ));
    }
  }

  void setLocation(LatLng location) {
    emit(state.copyWith(location: location));
  }

  void setDeliveryEnabled(bool enabled) {
    emit(state.copyWith(deliveryEnabled: enabled));
  }

  void setWorkingHours(String hours) {
    emit(state.copyWith(workingHours: hours));
  }

  void setOpenHour(String hour) {
    emit(state.copyWith(openHour: hour));
  }

  void setCloseHour(String hour) {
    emit(state.copyWith(closeHour: hour));
  }

  Future<void> uploadDocuments() async {
    if (!state.canContinue) {
      emit(state.copyWith(errorMessage: 'Please fill all required fields'));
      return;
    }

    emit(state.copyWith(isUploading: true, errorMessage: null));

    final result = await _signUpRepository.completePharmacySignUp(
        pharmacyModel: CompletePharmacyModel(
      pharmacyLicensePhoto: state.licensePhoto!,
      idPhoto: state.idPhoto!,
      location: state.location!,
      numberOfWorkingHours: state.workingHours!,
      isDeliveryEnabled: state.deliveryEnabled,
      closeHour: state.closeHour!,
      openHour: state.openHour!,
    ));

    emit(
      result.fold(
        (failure) => state.copyWith(
          isUploading: false,
          uploadSuccess: false,
          errorMessage: failure.errorMessage,
        ),
        (_) => state.copyWith(
          isUploading: false,
          uploadSuccess: true,
        ),
      ),
    );
  }
}
