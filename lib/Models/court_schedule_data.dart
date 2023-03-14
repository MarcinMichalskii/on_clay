import 'package:freezed_annotation/freezed_annotation.dart';
part 'court_schedule_data.g.dart';

@JsonSerializable()
class CourtScheduleData {
  final String clubName;
  final String clubPath;
  final DateTime scheduleForDay;
  final DateTime syncTime;
  final String courtName;
  final List<String> availableHours;
  final int timeSpan;

  CourtScheduleData(
      {required this.clubName,
      required this.clubPath,
      required this.scheduleForDay,
      required this.syncTime,
      required this.courtName,
      required this.availableHours,
      required this.timeSpan});

  factory CourtScheduleData.fromJson(Map<String, dynamic> json) =>
      _$CourtScheduleDataFromJson(json);

  Map<String, dynamic> toJson() => _$CourtScheduleDataToJson(this);
}
