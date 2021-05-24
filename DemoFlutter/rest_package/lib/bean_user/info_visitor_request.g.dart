// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_visitor_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoVisitorRequest _$InfoVisitorRequestFromJson(Map<String, dynamic> json) {
  return InfoVisitorRequest(
    json['id'] as String,
    json['username'] as String,
    json['reqRefNo'] as String,
  );
}

Map<String, dynamic> _$InfoVisitorRequestToJson(InfoVisitorRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'id': instance.id,
      'username': instance.username,
    };
