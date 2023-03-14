import 'package:flutter/material.dart';

extension FormattedHoursMinutes on TimeOfDay {
  String get formattedHoursMinutes {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }
}
