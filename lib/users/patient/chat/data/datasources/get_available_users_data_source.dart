import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/models/user_model.dart';
import 'package:canc_app/core/networking/api_constant.dart';
import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/end_point.dart';

class GetAvailableUsersDataSource {
  final ApiConsumer _apiConsumer;

  GetAvailableUsersDataSource(this._apiConsumer);

  Future<List<UserModel>> getUsers(int categoryIndex) async {
    final response = await _apiConsumer.get(
      EndPoint.getUsers,
      data: {
        ApiConstant.userType: _getUserType(categoryIndex),
      },
    );

    if (response is List) {
      return response
          .map((user) => UserModel.fromJson(user as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Invalid response format');
  }

  String _getUserType(int categoryIndex) {
    switch (categoryIndex) {
      case 0:
        return UsersKey.doctor;
      case 1:
        return UsersKey.pharmacist;
      case 2:
        return UsersKey.psychiatrist;
      case 3:
        return UsersKey.volunteer;
      case 4:
        return UsersKey.patient;
      default:
        return UsersKey.patient;
    }
  }
}
