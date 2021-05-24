// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceUpdateRequest _$DeviceUpdateRequestFromJson(Map<String, dynamic> json) {
  return DeviceUpdateRequest(
    json['rec_id'],
    json['msCategory'] as String,
    json['code'] as String,
    json['name'] as String,
    json['reqRefNo'] as String,
  );
}

Map<String, dynamic> _$DeviceUpdateRequestToJson(
        DeviceUpdateRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'rec_id': instance.rec_id,
      'msCategory': instance.msCategory,
      'code': instance.code,
      'name': instance.name,
    };
