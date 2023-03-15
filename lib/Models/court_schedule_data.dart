import 'package:freezed_annotation/freezed_annotation.dart';
part 'court_schedule_data.g.dart';

@JsonSerializable()
class CourtScheduleData {
  final DateTime syncTime;
  final String courtName;
  final List<String> availableHours;
  final int timeSpan;

  CourtScheduleData(
      {required this.syncTime,
      required this.courtName,
      required this.availableHours,
      required this.timeSpan});

  factory CourtScheduleData.fromJson(Map<String, dynamic> json) =>
      _$CourtScheduleDataFromJson(json);

  Map<String, dynamic> toJson() => _$CourtScheduleDataToJson(this);
}
