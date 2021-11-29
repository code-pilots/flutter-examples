import 'package:json_annotation/json_annotation.dart';

part 'date_model.g.dart';

@JsonSerializable()
class DateModel {
  final DateTime? date;

  @JsonKey(name: 'timezone_type')
  final int timezoneType;

  final String timezone;

  DateModel({
    this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory DateModel.fromJson(Map<String, dynamic> json) => _$DateModelFromJson(json);

  Map<String, dynamic> toJson() => _$DateModelToJson(this);
}