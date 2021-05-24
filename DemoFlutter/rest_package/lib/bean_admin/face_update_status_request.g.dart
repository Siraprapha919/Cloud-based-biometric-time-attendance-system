// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_update_status_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceUpdateStatusRequest _$FaceUpdateStatusRequestFromJson(
    Map<String, dynamic> json) {
  return FaceUpdateStatusRequest(
    json['id'] as String,
    json['image'] as String,
    json['statusExtraction'] as String,
    json['reqRefNo'] as String,
  );
}

Map<String, dynamic> _$FaceUpdateStatusRequestToJson(
        FaceUpdateStatusRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'id': instance.id,
      'image': instance.image,
      'statusExtraction': instance.statusExtraction,
    };
