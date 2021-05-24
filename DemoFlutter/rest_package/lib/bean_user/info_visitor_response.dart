import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';
part 'info_visitor_response.g.dart';

@JsonSerializable()
class InfoVisitorResponse extends BaseResponse{
  String image;
  InfoVisitorResponse(this.image,String respCode, String respDesc, String reqRefNo, String respRefNo) : super(respCode, respDesc, reqRefNo, respRefNo);
  factory InfoVisitorResponse.fromJson(Map<String, dynamic> json) =>
      _$InfoVisitorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InfoVisitorResponseToJson(this);
}