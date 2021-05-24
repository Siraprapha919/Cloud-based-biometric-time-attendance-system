// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faceExtraction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceExtractionRequest _$FaceExtractionRequestFromJson(
    Map<String, dynamic> json) {
  return FaceExtractionRequest(
    userid: json['userid'] as String,
    username: json['username'] as String,
    status: json['status'] as String,
    image: json['image'] as String,
    reqRefNo: json['reqRefNo'] as String,
  );
}

Map<String, dynamic> _$FaceExtractionRequestToJson(
        FaceExtractionRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'userid': instance.userid,
      'username': instance.username,
      'status': instance.status,
      'image': instance.image,
    };
