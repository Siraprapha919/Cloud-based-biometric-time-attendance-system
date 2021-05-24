// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_update_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceUpdateStatusResponse _$FaceUpdateStatusResponseFromJson(
    Map<String, dynamic> json) {
  return FaceUpdateStatusResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$FaceUpdateStatusResponseToJson(
        FaceUpdateStatusResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
    };
