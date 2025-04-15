import 'package:equatable/equatable.dart';

class FrequencyDetailsModel extends Equatable {
  final int? daysInterval; // For everyXDays
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
