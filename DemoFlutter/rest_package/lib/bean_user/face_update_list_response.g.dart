// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_update_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceUpdateListResponse _$FaceUpdateListResponseFromJson(
    Map<String, dynamic> json) {
  return FaceUpdateListResponse(
    json['model'] as List,
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$FaceUpdateListResponseToJson(
        FaceUpdateListResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'model': instance.model,
    };
