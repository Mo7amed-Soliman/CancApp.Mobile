import 'package:image_picker/image_picker.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {
  final XFile? image;

  EditProfileInitial({this.image});
}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {}

class EditProfileFailure extends EditProfileState {
  final String error;
  EditProfileFailure(this.error);
}

class EditProfileImageChanged extends EditProfileState {
  final XFile image;
  EditProfileImageChanged(this.image);
}
