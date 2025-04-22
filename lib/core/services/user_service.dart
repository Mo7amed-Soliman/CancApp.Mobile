import 'package:canc_app/core/models/user_model.dart';
import 'package:canc_app/core/helpers/database/hive_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserService {
  late Box<UserModel> _userBox;

  Future<void> init() async {
    _userBox = await Hive.openBox<UserModel>(HiveHelper.userBox);
  }

  Future<void> saveUser(UserModel user) async {
    await _userBox.put(HiveHelper.userBox, user);
  }

  UserModel? getUser() {
    return _userBox.get(HiveHelper.userBox);
  }

  Future<void> deleteUser() async {
    await _userBox.delete(HiveHelper.userBox);
  }
}
