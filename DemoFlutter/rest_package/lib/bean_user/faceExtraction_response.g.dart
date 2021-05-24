// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faceExtraction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceExtractionResponse _$FaceExtractionResponseFromJson(
    Map<String, dynamic> json) {
  return FaceExtractionResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$FaceExtractionResponseToJson(
        FaceExtractionResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
    };
