// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaveReq_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveResponse _$LeaveResponseFromJson(Map<String, dynamic> json) {
  return LeaveResponse(
    json['statusRequest'] as String,
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$LeaveResponseToJson(LeaveResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'statusRequest': instance.statusRequest,
    };
