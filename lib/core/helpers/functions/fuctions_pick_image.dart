import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
class FuctionsPickImage {
  static Future<File?> pickImageGallery() async {
    File? image;
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      image = File(file.path);
    }
    return image;
  }

  static Future<File?> pickImageCamera() async {
    File? image;
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.camera);
    if (file != null) {
      image = File(file.path);
    }
    return image;
  }

  static Future<PlatformFile?> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      return file;
    }
    return null;
  }
}
