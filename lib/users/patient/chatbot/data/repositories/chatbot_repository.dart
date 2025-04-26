import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:dartz/dartz.dart';

abstract class ChatBotRepository {
  Future<Either<Failure, String>> sendMessage(String message);
}
