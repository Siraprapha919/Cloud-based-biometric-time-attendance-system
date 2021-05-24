// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_black_white_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceBlackWhiteResponse _$FaceBlackWhiteResponseFromJson(
    Map<String, dynamic> json) {
  return FaceBlackWhiteResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$FaceBlackWhiteResponseToJson(
        FaceBlackWhiteResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
    };
