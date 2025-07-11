class AccessRequestModel {
  final String id;
  final String doctorImage;
  final String doctorName;
  final DateTime requestedAt;

  const AccessRequestModel({
    required this.id,
    required this.doctorImage,
    required this.doctorName,
    required this.requestedAt,
  });

  factory AccessRequestModel.fromJson(Map<String, dynamic> json) {
    return AccessRequestModel(
      id: json['id'].toString(),
      doctorImage: json['doctorImage'],
      doctorName: json['doctorName'],
      requestedAt: DateTime.parse(json['requestedAt']),
    );
  }
}
