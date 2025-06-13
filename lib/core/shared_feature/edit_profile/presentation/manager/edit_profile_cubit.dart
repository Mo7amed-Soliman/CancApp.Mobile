import 'package:canc_app/core/shared_feature/edit_profile/data/models/edit_profile_model.dart';
import 'package:canc_app/core/shared_feature/edit_profile/data/repositories/edit_profile_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'edit_profile_state.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({required EditProfileRepository editProfileRepository})
      : _editProfileRepository = editProfileRepository,
        super(EditProfileInitial());

  XFile? selectedImage;
  final EditProfileRepository _editProfileRepository;

  Future<void> pickImage({required ImageSource source}) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);

    if (picked != null) {
      selectedImage = XFile(picked.path);
      emit(EditProfileImageChanged(selectedImage!));
    }
  }

  Future<void> saveProfile(
      {required String name, required String address}) async {
    emit(EditProfileLoading());
    final result = await _editProfileRepository.updateProfile(
      EditProfileModel(
        name: name,
        address: address,
        image: selectedImage,
      ),
    );
    result.fold(
      (failure) => emit(EditProfileFailure(failure.toString())),
      (success) => emit(EditProfileSuccess()),
    );
  }
}
