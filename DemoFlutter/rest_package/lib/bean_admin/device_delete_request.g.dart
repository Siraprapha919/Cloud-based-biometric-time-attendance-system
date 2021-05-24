// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_delete_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceDeleteRequest _$DeviceDeleteRequestFromJson(Map<String, dynamic> json) {
  return DeviceDeleteRequest(
    json['deviceCode'] as String,
    json['loginNameStaff'] as String,
    json['reqRefNo'] as String,
  );
}

Map<String, dynamic> _$DeviceDeleteRequestToJson(
        DeviceDeleteRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'deviceCode': instance.deviceCode,
      'loginNameStaff': instance.loginNameStaff,
    };
