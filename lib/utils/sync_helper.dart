import 'package:on_clay/Models/clubs_data.dart';
import 'package:on_clay/utils/time_helper.dart';

class SyncHelper {
  static bool shouldSynchornizeFor(ClubData club, DateTime selectedDate) {
    final schedules =
        club.fetchedSchedules[TimeHelper().dateFormattedForAPI(selectedDate)];
    if (schedules == null) {
      return true;
    }
    if (schedules.isEmpty) {
      return true;
    }

    final isAnyScheduleOlderThan5Minutes = schedules.any((schedule) {
      final isOlderThan5Minutes =
          DateTime.now().difference(schedule.syncTime).inMinutes > 5;
      return isOlderThan5Minutes;
    });

    if (isAnyScheduleOlderThan5Minutes) {
      return true;
    }

    return false;
  }
}
