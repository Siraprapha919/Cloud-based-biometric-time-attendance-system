// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceUpdateResponse _$FaceUpdateResponseFromJson(Map<String, dynamic> json) {
  return FaceUpdateResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$FaceUpdateResponseToJson(FaceUpdateResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
    };
