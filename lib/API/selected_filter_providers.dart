import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_clay/Models/clubs_groups.dart';

final selectedDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

final selectedStartTimeProvider = StateProvider<TimeOfDay>(
  (ref) => TimeOfDay(hour: 10, minute: 10),
);

final selectedEndTimeProvider = StateProvider<TimeOfDay>(
  (ref) => TimeOfDay(hour: 23, minute: 59),
);

final selectedGroupProvider = StateProvider<ClubsGroup>(
  (ref) => defaultGroups[3],
);
