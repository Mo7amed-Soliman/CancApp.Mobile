import 'package:image_picker/image_picker.dart';

class SignUpModel {
  final String email;
  final String password;
  final String name;
  final String address;
  final XFile? image;
  final String userType;

  SignUpModel({
    required this.email,
    required this.password,
    required this.name,
    required this.address,
    required this.userType,
    this.image,
  });
}
