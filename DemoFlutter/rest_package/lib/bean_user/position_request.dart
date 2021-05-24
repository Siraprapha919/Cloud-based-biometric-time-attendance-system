import 'package:json_annotation/json_annotation.dart';

import 'base_request.dart';
part 'position_request.g.dart';

@JsonSerializable()
class PositionRequest extends BaseRequest{
  PositionRequest(String reqRefNo) : super(reqRefNo);
  factory PositionRequest.fromJson(Map<String, dynamic> json) =>
      _$PositionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PositionRequestToJson(this);

}