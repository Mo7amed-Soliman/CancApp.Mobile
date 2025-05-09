import 'dart:io';

class RecordModel {
  String id;
  File? image;
  String note;
  String date;

  RecordModel({
    required this.id,
    required this.date,
    required this.note,
    this.image,
  });
}

List<RecordModel> lists = [
  RecordModel(
    id: '1',
    note:
        'CT scan of my chest to monitor tumor size after the last chemotherapy session to check the progress of the treatment',
    image: File('assets/images/dummy_image/record.png'),
    date: '2025-01-22',
  ),
  RecordModel(
    id: '2',
    note:
        'CT scan of my chest to monitor tumor size after the last chemotherapy session to check the progress of the treatment. CT scan of my chest to monitor tumor size after the last chemotherapy session to check the progress of the treatment',
    image: File('assets/images/dummy_image/record.png'),
    date: '2025-01-22',
  ),
  RecordModel(
    id: '3',
    note:
        'CT scan of my chest to monitor tumor size after the last chemotherapy session to check the progress of the treatment. CT scan of my chest to monitor tumor size after the last chemotherapy session to check the progress of the treatment',
    image: File('assets/images/dummy_image/record.png'),
    date: '2025-01-22',
  ),
  RecordModel(
    id: '4',
    note:
        'CT scan of my chest to monitor tumor size after the last chemotherapy session to check the progress of the treatment. CT scan of my chest to monitor tumor size after the last chemotherapy session to check the progress of the treatment',
    image: File('assets/images/dummy_image/record.png'),
    date: '2025-01-22',
  ),
  RecordModel(
    id: '5',
    note:
        'CT scan of my chest to monitor tumor size after the last chemotherapy session to check the progress of the treatment',
    image: File('assets/images/dummy_image/record.png'),
    date: '2025-01-22',
  ),
];
