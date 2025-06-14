/// Model class for doctor record data
class RecordDoctorModel {
  final String id;
  final String name;
  final String imageUrl;
  final String date;
  final String note;
  final String type;

  const RecordDoctorModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.date,
    required this.note,
    required this.type,
  });
}
