// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigRequest _$ConfigRequestFromJson(Map<String, dynamic> json) {
  return ConfigRequest(
    json['scoreFaceCompare'] as String,
    json['timeAttendanceStart'] as String,
    json['timeAttendanceBeforeLate'] as String,
    json['timeAttendanceEnd'] as String,
    json['vacationDays'] as String,
    json['casualDays'] as String,
    json['sickDays'] as String,
    json['customerNo'] as String,
    json['nameEn'] as String,
    json['position'] as String,
    json['reqRefNo'] as String,
  );
}

Map<String, dynamic> _$ConfigRequestToJson(ConfigRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'scoreFaceCompare': instance.scoreFaceCompare,
      'timeAttendanceStart': instance.timeAttendanceStart,
      'timeAttendanceBeforeLate': instance.timeAttendanceBeforeLate,
      'timeAttendanceEnd': instance.timeAttendanceEnd,
      'vacationDays': instance.vacationDays,
      'casualDays': instance.casualDays,
      'sickDays': instance.sickDays,
      'customerNo': instance.customerNo,
      'nameEn': instance.nameEn,
      'position': instance.position,
    };
