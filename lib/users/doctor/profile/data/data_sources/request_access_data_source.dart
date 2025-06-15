import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/networking/api_constant.dart';
import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/end_point.dart';
import 'package:canc_app/users/doctor/profile/data/model/access_request_doctor_model.dart';
import 'package:canc_app/users/doctor/profile/data/model/record_doctor_model.dart';

class RequestAccessDataSource {
  final ApiConsumer _apiConsumer;

  RequestAccessDataSource(this._apiConsumer);

  Future<List<AccessRequestDoctorModel>> getAllPatient() async {
    final response = await _apiConsumer.get(
      EndPoint.getUsers,
      data: {
        ApiConstant.userType: UsersKey.patient,
      },
    );

    if (response is List) {
      return response
          .map((e) =>
              AccessRequestDoctorModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic>) {
      // Handle case where response might be wrapped in an object
      final data = response['data'] ?? response;
      if (data is List) {
        return data
            .map((e) =>
                AccessRequestDoctorModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    }
    throw Exception('Invalid response format: $response');
  }

  Future<void> sendAccess({
    required String patientId,
    required String doctorId,
  }) async {
    await _apiConsumer.post(
      EndPoint.sendAccess,
      data: {
        'patientId': patientId,
        'doctorId': doctorId,
      },
    );
  }

  //
  Future<List<RecordDoctorModel>> getRecordsForPatient(
      {required String patientId, required String doctorId}) async {
    final response = await _apiConsumer.get(
      EndPoint.recordsForPatient,
      data: {
        'patientId': patientId,
        'doctorId': doctorId,
      },
    );
    if (response is List) {
      return response
          .map((e) => RecordDoctorModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Invalid response format: $response');
  }

  ///RequestAccess/accepted-patients
  Future<List<AccessRequestDoctorModel>> getAcceptedPatients() async {
    final response = await _apiConsumer.get(EndPoint.getAcceptedPatients);
    if (response is List) {
      return response
          .map((e) =>
              AccessRequestDoctorModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Invalid response format: $response');
  }
}
