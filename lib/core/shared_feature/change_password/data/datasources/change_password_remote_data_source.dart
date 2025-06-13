import 'package:canc_app/core/networking/api_constant.dart';
import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/end_point.dart';

abstract class ChangePasswordRemoteDataSource {
  Future<void> changePassword(String oldPassword, String newPassword);
}

class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSource {
  final ApiConsumer apiConsumer;

  ChangePasswordRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    await apiConsumer.post(
      EndPoint.changePassword,
      data: {
        ApiConstant.oldPassword: oldPassword,
        ApiConstant.newPassword: newPassword,
      },
    );
  }
}
