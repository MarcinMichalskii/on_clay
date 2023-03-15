import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:on_clay/Models/court_schedule_data.dart';
import 'package:on_clay/schedule_helper.dart';
part 'clubs_data.g.dart';

@CopyWith()
class ClubData {
  final String clubName;
  final String clubPath;
  final String street;
  final String addressDetails;
  final Map<String, List<CourtScheduleData>> fetchedSchedules;
  ClubData(
      {required this.clubName,
      required this.clubPath,
      required this.fetchedSchedules,
      required this.street,
      required this.addressDetails});
}
