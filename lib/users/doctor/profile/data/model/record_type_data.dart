import 'package:flutter/foundation.dart';

@immutable
class RecordTypeData {
  final int index;
  final String recordType;

  const RecordTypeData({
    required this.index,
    required this.recordType,
  });

  Map<String, dynamic> toJson() => {
        'index': index,
        'recordType': recordType,
      };

  factory RecordTypeData.fromJson(Map<String, dynamic> json) => RecordTypeData(
        index: json['index'] as int,
        recordType: json['recordType'] as String,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordTypeData &&
          runtimeType == other.runtimeType &&
          index == other.index &&
          recordType == other.recordType;

  @override
  int get hashCode => Object.hash(index, recordType);
}
