import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:canc_app/core/networking/end_point.dart';
import 'package:dio/dio.dart';

class ChatbotRemoteDataSource {
  final Dio _dio;

  ChatbotRemoteDataSource({
    required Dio dio,
  }) : _dio = dio {
    _dio.options.baseUrl = EndPoint.chatbotBaseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<String> sendMessage(String message) async {
    try {
      final response = await _dio.post(
        '${EndPoint.chatbotBaseUrl}${EndPoint.charbotAsk}',
        data: {
          'question': message,
        },
      );
      return response.data['answer'];
    } on DioException catch (e) {
      String errorMessage =
          'Sorry, there was an error connecting to the server.';
      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage =
            'Connection timed out. Please check your internet connection.';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Server took too long to respond. Please try again.';
      } else if (e.type == DioExceptionType.unknown) {
        errorMessage = 'Network error. Please check your internet connection.';
      }
      throw Failure(errorMessage);
    }
  }
}
