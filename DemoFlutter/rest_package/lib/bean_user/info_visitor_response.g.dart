// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_visitor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoVisitorResponse _$InfoVisitorResponseFromJson(Map<String, dynamic> json) {
  return InfoVisitorResponse(
    json['image'] as String,
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$InfoVisitorResponseToJson(
        InfoVisitorResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'image': instance.image,
    };
