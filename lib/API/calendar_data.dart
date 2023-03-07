import 'package:freezed_annotation/freezed_annotation.dart';
part 'calendar_data.g.dart';

@JsonSerializable(createToJson: false)
class CalendarData {
  CalendarData({required this.schedule});

  factory CalendarData.fromJson(Map<String, dynamic> json) =>
      _$CalendarDataFromJson(json);
  final String schedule;
}
