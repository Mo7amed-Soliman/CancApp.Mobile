import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/users/patient/home/data/models/access_request_model';

class AccessRequestDataSource {
  final ApiConsumer _apiConsumer;

  AccessRequestDataSource(this._apiConsumer);

  Future<List<AccessRequestModel>> getPendingRequests() async {
    final response = await _apiConsumer.get('RequestAccess/pending-requests');

    final List<dynamic> requestsJson = response['value'] as List<dynamic>;
    return requestsJson
        .map((json) => AccessRequestModel.fromJson(json))
        .toList();
  }

  Future<void> approveAccess({
    required String requestId,
    required bool approve,
  }) async {
    await _apiConsumer.post(
      'RequestAccess/approve-access',
      data: {
        'requestId': requestId,
        'approve': approve,
      },
    );
  }
}
