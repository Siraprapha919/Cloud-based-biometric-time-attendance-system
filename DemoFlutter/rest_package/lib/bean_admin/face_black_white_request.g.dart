// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_black_white_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceBlackWhiteRequest _$FaceBlackWhiteRequestFromJson(
    Map<String, dynamic> json) {
  return FaceBlackWhiteRequest(
    json['id'] as String,
    json['status'] as String,
    json['reqRefNo'],
  );
}

Map<String, dynamic> _$FaceBlackWhiteRequestToJson(
        FaceBlackWhiteRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'id': instance.id,
      'status': instance.status,
    };
