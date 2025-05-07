import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'edit_profile_state.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  File? selectedImage;

  Future<void> pickImage({required ImageSource source}) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);

    if (picked != null) {
      selectedImage = File(picked.path);
      emit(EditProfileImageChanged(selectedImage!));
    }
  }

  Future<void> saveProfile(
      {required String name, required String address}) async {
    emit(EditProfileLoading());
    try {
      // Simulate saving logic
      await Future.delayed(const Duration(seconds: 2));

      // Add image upload logic if needed here.

      emit(EditProfileSuccess());
    } catch (e) {
      emit(EditProfileFailure(e.toString()));
    }
  }
}
