// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_delete_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceDeleteResponse _$DeviceDeleteResponseFromJson(Map<String, dynamic> json) {
  return DeviceDeleteResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$DeviceDeleteResponseToJson(
        DeviceDeleteResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
    };
