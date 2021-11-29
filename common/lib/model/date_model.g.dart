// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateModel _$DateModelFromJson(Map<String, dynamic> json) {
  return DateModel(
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    timezoneType: json['timezone_type'] as int,
    timezone: json['timezone'] as String,
  );
}

Map<String, dynamic> _$DateModelToJson(DateModel instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'timezone_type': instance.timezoneType,
      'timezone': instance.timezone,
    };
