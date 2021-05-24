// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoResponse _$UserInfoResponseFromJson(Map<String, dynamic> json) {
  return UserInfoResponse(
    json['recId'],
    json['employeeNo'] as String,
    json['fname'] as String,
    json['lname'] as String,
    json['image'] as String,
    json['mobileNo'] as String,
    json['role'] as String,
    json['email'] as String,
    json['faceRegisStatus'] as String,
    json['faceStatus'] as String,
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$UserInfoResponseToJson(UserInfoResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'recId': instance.recId,
      'employeeNo': instance.employeeNo,
      'fname': instance.fname,
      'lname': instance.lname,
      'image': instance.image,
      'mobileNo': instance.mobileNo,
      'role': instance.role,
      'email': instance.email,
      'faceRegisStatus': instance.faceRegisStatus,
      'faceStatus': instance.faceStatus,
    };
