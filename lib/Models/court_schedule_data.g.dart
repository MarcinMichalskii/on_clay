// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'court_schedule_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourtScheduleData _$CourtScheduleDataFromJson(Map<String, dynamic> json) =>
    CourtScheduleData(
      syncTime: DateTime.parse(json['syncTime'] as String),
      courtName: json['courtName'] as String,
      availableHours: (json['availableHours'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      timeSpan: json['timeSpan'] as int,
    );

Map<String, dynamic> _$CourtScheduleDataToJson(CourtScheduleData instance) =>
    <String, dynamic>{
      'syncTime': instance.syncTime.toIso8601String(),
      'courtName': instance.courtName,
      'availableHours': instance.availableHours,
      'timeSpan': instance.timeSpan,
    };
