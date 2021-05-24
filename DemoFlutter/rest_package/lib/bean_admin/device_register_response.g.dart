// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceRegisterResponse _$DeviceRegisterResponseFromJson(
    Map<String, dynamic> json) {
  return DeviceRegisterResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$DeviceRegisterResponseToJson(
        DeviceRegisterResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
    };
