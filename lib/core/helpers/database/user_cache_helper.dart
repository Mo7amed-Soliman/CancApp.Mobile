import 'package:canc_app/core/models/user_model.dart';
import 'package:canc_app/core/helpers/database/hive_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserCacheHelper {
  static Future<void> init() async {
    await Hive.openBox<UserModel>(HiveHelper.userBox);
  }

  static Box<UserModel> openUserBox() {
    return Hive.box<UserModel>(HiveHelper.userBox);
  }

  static Future<void> saveUser(UserModel user) async {
    final box = openUserBox();
    await box.put(HiveHelper.userBox, user);
  }

  static UserModel? getUser() {
    final box = openUserBox();
    return box.get(HiveHelper.userBox);
  }

  static Future<void> deleteUser() async {
    final box = openUserBox();
    await box.delete(HiveHelper.userBox);
  }

  static Future<void> updateUser(UserModel user) async {
    final box = openUserBox();
    await box.put(HiveHelper.userBox, user);
  }
}
