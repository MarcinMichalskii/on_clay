import 'package:flutter/material.dart';
import 'package:on_clay/utils/time_helper.dart';

class ReservationsHelper {
  static bool isReservationPossible(String timeRange, TimeOfDay startTime,
      {TimeOfDay? endTime}) {
    // Parse the time range into start and end times
    List<String> times = timeRange.split(' - ');
    String rangeStartHour = times[0];
    String rangeEndHour = times[1];
    DateTime rangeStart = TimeHelper().createTimeFromString(rangeStartHour);
    DateTime rangeEnd = TimeHelper().createTimeFromString(rangeEndHour);
    String formattedEarliestStart =
        '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
    DateTime earliestStart =
        TimeHelper().createTimeFromString(formattedEarliestStart);
    String latestEndHour = endTime?.hour.toString().padLeft(2, '0') ?? '23';
    String latestEndMinute = endTime?.minute.toString().padLeft(2, '0') ?? '59';
    DateTime latestEnd =
        TimeHelper().createTimeFromString('$latestEndHour:$latestEndMinute');

    if (rangeStart.difference(rangeEnd).inMinutes.abs() < 60) {
      return false;
    }

    if (latestEnd.isBefore(rangeEnd)) {
      rangeEnd = latestEnd;
    }
    if (earliestStart.isAfter(rangeEnd) ||
        earliestStart.add(Duration(minutes: 59)).isAfter(rangeEnd)) {
      return false;
    }

    if (rangeStart.add(Duration(hours: 1)).isAfter(latestEnd)) {
      return false;
    }

    return true;
  }
}
