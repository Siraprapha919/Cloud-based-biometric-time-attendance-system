// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoRequest _$UserInfoRequestFromJson(Map<String, dynamic> json) {
  return UserInfoRequest(
    json['id'] as String,
    json['mobileNo'] as String,
    json['reqRefNo'] as String,
  );
}

Map<String, dynamic> _$UserInfoRequestToJson(UserInfoRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'id': instance.id,
      'mobileNo': instance.mobileNo,
    };
