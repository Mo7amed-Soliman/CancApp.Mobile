import 'package:image_picker/image_picker.dart';

class CompleteDoctorRegistrationState {
  final XFile? syndicatePhoto;
  final XFile? idPhoto;
  final bool isUploading;
  final bool uploadSuccess;
  final String? errorMessage;

  const CompleteDoctorRegistrationState({
    required this.syndicatePhoto,
    required this.idPhoto,
    required this.isUploading,
    required this.uploadSuccess,
    this.errorMessage,
  });

  factory CompleteDoctorRegistrationState.initial() {
    return const CompleteDoctorRegistrationState(
      syndicatePhoto: null,
      idPhoto: null,
      isUploading: false,
      uploadSuccess: false,
    );
  }

  bool get canContinue => syndicatePhoto != null && idPhoto != null;

  CompleteDoctorRegistrationState copyWith({
    XFile? syndicatePhoto,
    XFile? idPhoto,
    bool? isUploading,
    bool? uploadSuccess,
    String? errorMessage,
  }) {
    return CompleteDoctorRegistrationState(
      syndicatePhoto: syndicatePhoto ?? this.syndicatePhoto,
      idPhoto: idPhoto ?? this.idPhoto,
      isUploading: isUploading ?? this.isUploading,
      uploadSuccess: uploadSuccess ?? this.uploadSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
