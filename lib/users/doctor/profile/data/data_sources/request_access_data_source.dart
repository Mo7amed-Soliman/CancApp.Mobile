import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/end_point.dart';

class RequestAccessDataSource {
  final ApiConsumer _apiConsumer;

  RequestAccessDataSource(this._apiConsumer);

  Future<void> requestAccess({
    required String patientId,
    required String doctorId,
  }) async {
    await _apiConsumer.post(
      EndPoint.requestAccess,
      data: {
        'patientId': patientId,
        'doctorId': doctorId,
      },
    );
  }
}
