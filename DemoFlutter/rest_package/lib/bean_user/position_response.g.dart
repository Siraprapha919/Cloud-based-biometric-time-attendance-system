// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionResponse _$PositionResponseFromJson(Map<String, dynamic> json) {
  return PositionResponse(
    json['position'] as List,
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$PositionResponseToJson(PositionResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'position': instance.position,
    };
