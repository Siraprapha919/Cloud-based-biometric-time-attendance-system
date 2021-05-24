// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deviceAll_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceAllResponse _$DeviceAllResponseFromJson(Map<String, dynamic> json) {
  return DeviceAllResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    json['deviceAll'] as List,
  );
}

Map<String, dynamic> _$DeviceAllResponseToJson(DeviceAllResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'deviceAll': instance.deviceAll,
    };
