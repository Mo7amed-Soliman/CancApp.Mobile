import 'package:flutter/material.dart';
import 'package:canc_app/generated/l10n.dart';

enum Frequency {
  everyDay,
  daysOfWeek,
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
