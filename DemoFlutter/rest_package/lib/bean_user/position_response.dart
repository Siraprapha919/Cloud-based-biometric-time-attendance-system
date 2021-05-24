import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';
part 'position_response.g.dart';

@JsonSerializable()
class PositionResponse extends BaseResponse{
  List position;
  PositionResponse(this.position,String respCode, String respDesc, String reqRefNo, String respRefNo) : super(respCode, respDesc, reqRefNo, respRefNo);
  factory PositionResponse.fromJson(Map<String, dynamic> json) =>
      _$PositionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PositionResponseToJson(this);
}