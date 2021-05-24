// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitorResponse _$VisitorResponseFromJson(Map<String, dynamic> json) {
  return VisitorResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    json['attendance'] as List,
  );
}

Map<String, dynamic> _$VisitorResponseToJson(VisitorResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'attendance': instance.attendance,
    };
