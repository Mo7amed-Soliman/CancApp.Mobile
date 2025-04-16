import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'frequency_details_model.g.dart';

@HiveType(typeId: 2)
class FrequencyDetailsModel extends Equatable {
  @HiveField(0)
  final int? daysInterval; // For everyXDays
  @HiveField(1)
  final List<int>? daysOfWeek; // For daysOfWeek (0-6, where 0 is Sunday)

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
