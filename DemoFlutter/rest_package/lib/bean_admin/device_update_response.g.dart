// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceUpdateResponse _$DeviceUpdateResponseFromJson(Map<String, dynamic> json) {
  return DeviceUpdateResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$DeviceUpdateResponseToJson(
        DeviceUpdateResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
    };
