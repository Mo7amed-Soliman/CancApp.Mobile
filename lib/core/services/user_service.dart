import 'package:canc_app/core/models/user_model.dart';
import 'package:canc_app/core/helpers/database/hive_helper.dart';
import 'package:hive/hive.dart';

class UserService {
  late Box<UserModel> _userBox;

  Future<void> init() async {
    try {
      _userBox = await Hive.openBox<UserModel>(HiveHelper.userBox);
    } catch (e) {
      // If there's an error, try to delete the box and recreate it
      await Hive.deleteBoxFromDisk(HiveHelper.userBox);
      _userBox = await Hive.openBox<UserModel>(HiveHelper.userBox);
    }
  }

  Future<void> saveUser(UserModel user) async {
    await _userBox.put('currentUser', user);
  }

  UserModel? getUser() {
    return _userBox.get('currentUser');
  }

  Future<void> deleteUser() async {
    await _userBox.delete('currentUser');
  }

  bool isUserLoggedIn() {
    return _userBox.containsKey('currentUser');
  }
}
