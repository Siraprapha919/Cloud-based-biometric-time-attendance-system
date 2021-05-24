// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_face_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFaceResponse _$GetFaceResponseFromJson(Map<String, dynamic> json) {
  return GetFaceResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    json['model'] as List,
  );
}

Map<String, dynamic> _$GetFaceResponseToJson(GetFaceResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'model': instance.model,
    };
