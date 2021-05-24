// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getInfo_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetInfoRequest _$GetInfoRequestFromJson(Map<String, dynamic> json) {
  return GetInfoRequest(
    json['id'] as String,
    json['mobileNo'] as String,
    json['reqRefNo'] as String,
  );
}

Map<String, dynamic> _$GetInfoRequestToJson(GetInfoRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'id': instance.id,
      'mobileNo': instance.mobileNo,
    };
