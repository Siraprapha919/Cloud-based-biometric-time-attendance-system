import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';
part 'face_update_list_response.g.dart';
@JsonSerializable()
class FaceUpdateListResponse extends BaseResponse{
  List model;
  FaceUpdateListResponse(this.model,String respCode, String respDesc, String reqRefNo, String respRefNo) : super(respCode, respDesc, reqRefNo, respRefNo);
  factory FaceUpdateListResponse.fromJson(Map<String, dynamic> json) =>
      _$FaceUpdateListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FaceUpdateListResponseToJson(this);
}