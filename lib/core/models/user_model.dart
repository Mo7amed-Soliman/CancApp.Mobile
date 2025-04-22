import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

part 'user_model.g.dart';

@HiveType(typeId: 4)
class UserModel extends HiveObject {
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

  UserModel({
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
      userType: getIt<CacheHelper>().getDataString(key: CacheKeys.whoAreYou),
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
}
