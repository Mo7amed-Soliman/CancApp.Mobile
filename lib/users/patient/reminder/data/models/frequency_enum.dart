import 'package:canc_app/core/helpers/database/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:hive/hive.dart';

part 'frequency_enum.g.dart';

@HiveType(typeId: HiveHelper.frequencyBoxID)
enum Frequency {
  @HiveField(0)
  everyDay,
  @HiveField(1)
  daysOfWeek,
  @HiveField(2)
  everyXDays;

  String displayName(BuildContext context) {
    switch (this) {
      case Frequency.everyDay:
        return S.of(context).everyDay;
      case Frequency.daysOfWeek:
        return S.of(context).specificDays;
      case Frequency.everyXDays:
        return S.of(context).everyXDays;
    }
  }
}
