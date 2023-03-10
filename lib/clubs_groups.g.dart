// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clubs_groups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubsGroup _$ClubsGroupFromJson(Map<String, dynamic> json) => ClubsGroup(
      json['name'] as String,
      (json['ids'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ClubsGroupToJson(ClubsGroup instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ids': instance.ids,
    };
