part of 'manage_upload_image_cubit.dart';

@immutable
sealed class ManageUploadImageState {}

final class ManageUploadImageInitial extends ManageUploadImageState {}

final class FoundedImage extends ManageUploadImageState {
  final dynamic image;

  FoundedImage({required this.image});
}

final class EmptyImage extends ManageUploadImageState {}
