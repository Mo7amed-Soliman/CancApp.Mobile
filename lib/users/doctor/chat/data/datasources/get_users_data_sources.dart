import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/models/user_model.dart';
import 'package:canc_app/core/networking/api_constant.dart';
import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/end_point.dart';

class GetUsersDataSource {
  final ApiConsumer apiConsumer;

  GetUsersDataSource(this.apiConsumer);

  Future<List<UserModel>> getpatients() async {
    final response = await apiConsumer.get(
      EndPoint.getUsers,
      data: {
        ApiConstant.userType: UsersKey.patient,
      },
    );

    if (response is List) {
      return response
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Invalid response format');
  }
}
