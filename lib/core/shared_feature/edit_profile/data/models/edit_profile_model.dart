import 'package:image_picker/image_picker.dart';

class EditProfileModel {
  final String? name;
  final XFile? image;
  final String? address;

  EditProfileModel({
    this.name,
    this.image,
    this.address,
  });
}
