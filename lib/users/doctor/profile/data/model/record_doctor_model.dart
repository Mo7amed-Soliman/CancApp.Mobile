/// Model class for doctor record data
class RecordDoctorModel {
  final String userId;
  final String name;
  final String? imageUrl;
  final String date;
  final String note;
  final String recordType;

  const RecordDoctorModel({
    required this.userId,
    required this.name,
    this.imageUrl,
    required this.date,
    required this.note,
    required this.recordType,
  });
  factory RecordDoctorModel.fromJson(Map<String, dynamic> json) {
    return RecordDoctorModel(
      userId: json['id'],
      name: json['name'],
      imageUrl: json['file'],
      date: json['date'],
      note: json['note'],
      recordType: json['recordType'],
    );
  }
}
