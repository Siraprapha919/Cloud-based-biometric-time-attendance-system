// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceUpdateRequest _$FaceUpdateRequestFromJson(Map<String, dynamic> json) {
  return FaceUpdateRequest(
    json['id'] as String,
    json['image'] as String,
    json['reqRefNo'] as String,
  );
}

Map<String, dynamic> _$FaceUpdateRequestToJson(FaceUpdateRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'id': instance.id,
      'image': instance.image,
    };
