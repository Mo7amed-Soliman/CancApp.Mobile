import 'package:flutter/foundation.dart';

@immutable
class AccessRecordModel {
  final String patientId;
  final String patientName;
  final String patientImage;

  const AccessRecordModel({
    required this.patientId,
    required this.patientName,
    required this.patientImage,
  });

  Map<String, dynamic> toJson() => {
        'patientId': patientId,
        'patientName': patientName,
        'patientImage': patientImage,
      };

  factory AccessRecordModel.fromJson(Map<String, dynamic> json) =>
      AccessRecordModel(
        patientId: json['patientId'] as String,
        patientName: json['patientName'] as String,
        patientImage: json['patientImage'] as String,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccessRecordModel &&
          runtimeType == other.runtimeType &&
          patientId == other.patientId &&
          patientName == other.patientName &&
          patientImage == other.patientImage;

  @override
  int get hashCode => Object.hash(patientId, patientName, patientImage);
}
