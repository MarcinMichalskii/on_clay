import 'package:intl/intl.dart';

class TimeHelper {
  int getMinutesBetweenHours(String firstHour, String secondHour) {
    final firstTime = DateTime.parse("2000-01-01 $firstHour");
    final secondTime = DateTime.parse("2000-01-01 $secondHour");
    final difference = secondTime.difference(firstTime).inMinutes;
    return difference.abs();
  }

  String timeIncreasedByTimeSpan(String startingHour, int timespan) {
    final startingTime = DateTime.parse("2000-01-01 $startingHour");
    final endingTime = startingTime.add(Duration(minutes: timespan));
    final formattedTime =
        "${endingTime.hour.toString().padLeft(2, '0')}:${endingTime.minute.toString().padLeft(2, '0')}";
    return formattedTime;
  }

  String dateFormattedForAPI(DateTime date) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(date);
  }

  DateTime createTimeFromString(String timeString) {
    final firstTime = DateTime.parse("2000-01-01 $timeString");
    return firstTime;
  }

  static DateTime getNewerDate(DateTime date1, DateTime date2) {
    if (date1.isAfter(date2)) {
      return date1;
    } else {
      return date2;
    }
  }
}
