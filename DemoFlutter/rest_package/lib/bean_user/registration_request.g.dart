// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) {
  return RegisterRequest(
    firstname: json['firstname'] as String,
    lastname: json['lastname'] as String,
    mobile: json['mobile'] as String,
    role: json['role'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    img64: json['img64'] as String,
    reqRefNo: json['reqRefNo'] as String,
  );
}

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'mobile': instance.mobile,
      'role': instance.role,
      'email': instance.email,
      'password': instance.password,
      'img64': instance.img64,
    };
