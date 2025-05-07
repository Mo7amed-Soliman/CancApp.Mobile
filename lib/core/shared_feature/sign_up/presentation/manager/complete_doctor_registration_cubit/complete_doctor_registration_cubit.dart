import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repositories/sign_up_repository.dart';
import 'complete_doctor_registration_state.dart';

class CompleteDoctorRegistrationCubit
    extends Cubit<CompleteDoctorRegistrationState> {
  final ImagePicker _picker = ImagePicker();
  final SignUpRepository _signUpRepository;

  CompleteDoctorRegistrationCubit({required SignUpRepository signUpRepository})
      : _signUpRepository = signUpRepository,
        super(
          CompleteDoctorRegistrationState.initial(),
        );

  Future<void> pickImage({
    required ImageSource source,
    required bool isSyndicate,
  }) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (pickedFile != null) {
      if (isSyndicate) {
        emit(
          state.copyWith(syndicatePhoto: pickedFile),
        );
      } else {
        emit(
          state.copyWith(idPhoto: pickedFile),
        );
      }
    }
  }

  Future<void> uploadDocuments() async {
    if (!state.canContinue) return;

    emit(state.copyWith(isUploading: true));

    final result = await _signUpRepository.completeDoctorSignUp(
      idPhoto: state.idPhoto!,
      syndicatePhoto: state.syndicatePhoto!,
    );
    result.fold((failure) {
      emit(state.copyWith(
        isUploading: false,
        uploadSuccess: false,
        errorMessage: failure.errorMessage,
      ));
    }, ((_) {
      emit(state.copyWith(
        isUploading: false,
        uploadSuccess: true,
      ));
    }));
  }
}
