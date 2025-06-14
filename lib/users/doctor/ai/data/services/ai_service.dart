import 'dart:developer';

import 'package:dio/dio.dart';
import '../models/health_input_model.dart';

class AiService {
  static String baseUrl = 'https://3aea-35-245-123-231.ngrok-free.app';
  final _dio = Dio();

  Future<String> predictHealth(HealthInputModel input) async {
    log(input.toJson().toString());
    try {
      final response = await _dio.post(
        '$baseUrl/predict',
        data: input.toJson(),
      );

      if (response.statusCode == 200) {
        log(response.data['prediction'].toString());
        return response.data['prediction'];
      } else {
        throw Exception('Failed to get prediction: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Error making prediction: ${e.message}');
    }
  }
}
