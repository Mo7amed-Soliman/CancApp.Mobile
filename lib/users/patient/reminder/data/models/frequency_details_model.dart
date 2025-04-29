import 'package:canc_app/core/helpers/database/hive_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'frequency_details_model.g.dart';

@HiveType(typeId: HiveHelper.frequencyDetailsBoxID)
class FrequencyDetailsModel extends Equatable {
  @HiveField(0)
  final int? daysInterval; // For everyXDays
  @HiveField(1)
  final List<int>? daysOfWeek; // For daysOfWeek

  const FrequencyDetailsModel({
    this.daysInterval,
    this.daysOfWeek,
  });

  @override
  List<Object?> get props => [daysInterval, daysOfWeek];

  FrequencyDetailsModel copyWith({
    int? daysInterval,
    List<int>? daysOfWeek,
  }) {
    return FrequencyDetailsModel(
      daysInterval: daysInterval ?? this.daysInterval,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
    );
  }
}
