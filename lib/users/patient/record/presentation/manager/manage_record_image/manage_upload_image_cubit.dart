import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_upload_image_state.dart';

class ManageUploadImageCubit extends Cubit<ManageUploadImageState> {
  ManageUploadImageCubit() : super(ManageUploadImageInitial());

  void addGallery(dynamic image) {
    if (image != null) {
      emit(FoundedImage(image: image));
    } else {
      emit(EmptyImage());
    }
  }

  void deleteImage() {
    emit(EmptyImage());
  }
}
