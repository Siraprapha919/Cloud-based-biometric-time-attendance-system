// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceRegisterRequest _$DeviceRegisterRequestFromJson(
    Map<String, dynamic> json) {
  return DeviceRegisterRequest(
    json['msCategory'] as String,
    json['code'] as String,
    json['name'] as String,
    json['reqRefNo'] as String,
  );
}

Map<String, dynamic> _$DeviceRegisterRequestToJson(
        DeviceRegisterRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'msCategory': instance.msCategory,
      'code': instance.code,
      'name': instance.name,
    };
