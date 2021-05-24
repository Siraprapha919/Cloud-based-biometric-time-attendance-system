import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';


part 'leaveReq_response.g.dart';

@JsonSerializable()
class LeaveResponse extends BaseResponse {
  String statusRequest;
  LeaveResponse(this.statusRequest,String respCode, String respDesc, String reqRefNo, String respRefNo) : super(respCode, respDesc, reqRefNo, respRefNo);
  factory LeaveResponse.fromJson(Map<String, dynamic> json) =>
      _$LeaveResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveResponseToJson(this);

}
