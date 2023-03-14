import 'package:on_clay/Models/court_schedule_data.dart';

class ClubWithAvailability {
  final String club;
  final List<CourtScheduleData> courtsAvailability;

  ClubWithAvailability({required this.club, required this.courtsAvailability});
}

List<ClubWithAvailability> mergeByClubName(List<CourtScheduleData> data) {
  final Map<String, List<CourtScheduleData>> mergedData = {};

  for (final item in data) {
    final clubName = item.clubName;

    if (!mergedData.containsKey(clubName)) {
      mergedData[clubName] = [item];
    } else {
      mergedData[clubName]!.add(item);
    }
  }

  final List<ClubWithAvailability> clubsList = [];

  for (final entry in mergedData.entries) {
    clubsList.add(
        ClubWithAvailability(club: entry.key, courtsAvailability: entry.value));
  }

  return clubsList;
}
