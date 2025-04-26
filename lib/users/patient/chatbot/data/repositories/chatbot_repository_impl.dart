import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:dartz/dartz.dart';

import '../data_sources/chatbot_remote_data_source.dart';
import 'chatbot_repository.dart';

class ChatbotRepositoryImpl extends ChatBotRepository {
  final ChatbotRemoteDataSource _dataSource;

  ChatbotRepositoryImpl({
    required ChatbotRemoteDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<Either<Failure, String>> sendMessage(String message) async {
    try {
      final response = await _dataSource.sendMessage(message);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
