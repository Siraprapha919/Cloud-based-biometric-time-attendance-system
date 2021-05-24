// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) {
  return LoginRequest(
    json['mobileNo'] as String,
    json['password'] as String,
    json['reqRefNo'] as String,
  );
}

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'mobileNo': instance.mobileNo,
      'password': instance.password,
    };
