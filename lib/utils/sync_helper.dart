import 'package:on_clay/Models/court_schedule_data.dart';
import 'package:on_clay/schedule_helper.dart';
import 'package:on_clay/utils/extensions/date_time_extensions.dart';

class SyncHelper {
  static bool shouldSynchornizeFor(String clubName, DateTime selectedDate,
      List<CourtScheduleData> schedules) {
    final filteredSchedules = schedules.where((schedule) {
      final isSameClub = schedule.clubName == clubName;
      final isSameDay = schedule.scheduleForDay.isSameDay(selectedDate);
      return isSameClub && isSameDay;
    }).toList();
    final isAnyScheduleOlderThan5Minutes = filteredSchedules.any((schedule) {
      final isOlderThan5Minutes =
          DateTime.now().difference(schedule.syncTime).inMinutes > 5;
      return isOlderThan5Minutes;
    });
    return filteredSchedules.isEmpty || isAnyScheduleOlderThan5Minutes;
  }
}
