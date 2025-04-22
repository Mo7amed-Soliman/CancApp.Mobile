import 'package:canc_app/core/helpers/database/hive_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

part 'user_model.g.dart';

@HiveType(typeId: HiveHelper.userBoxID)
class UserModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String userName;

  @HiveField(3)
  final String name;

  @HiveField(4)
  final String address;

  @HiveField(5)
  final XFile? image;

  @HiveField(6)
  final String? userType;

  const UserModel({
    required this.id,
    required this.email,
    required this.userName,
    required this.name,
    required this.address,
    this.image,
    this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      userName: json['userName'],
      name: json['name'],
      address: json['address'],
      image: json['image'] != null ? XFile(json['image']) : null,
      userType: json['userType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
      'name': name,
      'address': address,
      'image': image?.path,
    };
  }

  @override
  List<Object?> get props =>
      [id, email, userName, name, address, image, userType];
}
