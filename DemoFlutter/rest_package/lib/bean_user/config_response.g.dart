// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigResponse _$ConfigResponseFromJson(Map<String, dynamic> json) {
  return ConfigResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$ConfigResponseToJson(ConfigResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
    };
