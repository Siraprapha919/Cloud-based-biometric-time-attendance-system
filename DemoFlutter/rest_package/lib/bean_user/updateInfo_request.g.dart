// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updateInfo_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateInfoRequest _$UpdateInfoRequestFromJson(Map<String, dynamic> json) {
  return UpdateInfoRequest(
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
    json['reqRefNo'] as String,
  );
}

Map<String, dynamic> _$UpdateInfoRequestToJson(UpdateInfoRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
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
