import 'dart:io';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {
  final File? image;

  EditProfileInitial({this.image});
}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {}

class EditProfileFailure extends EditProfileState {
  final String error;
  EditProfileFailure(this.error);
}

class EditProfileImageChanged extends EditProfileState {
  final File image;
  EditProfileImageChanged(this.image);
}
