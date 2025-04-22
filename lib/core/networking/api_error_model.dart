/// ApiErrorModel is a class that contains the error message and status code for the API.
class ApiErrorModel implements Exception {
  final int statusCode;
  final String errorMessage;

  ApiErrorModel({required this.statusCode, required this.errorMessage});
  factory ApiErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ApiErrorModel(
      statusCode: jsonData['status'],
      errorMessage: jsonData['errors'][1],
    );
  }
}
