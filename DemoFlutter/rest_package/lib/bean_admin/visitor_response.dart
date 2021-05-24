import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_response.dart';

part 'visitor_response.g.dart';

@JsonSerializable()
class VisitorResponse extends BaseResponse {
  List attendance;
  VisitorResponse(String respCode, String respDesc, String reqRefNo,
      String respRefNo, this.attendance)
      : super(respCode, respDesc, reqRefNo, respRefNo);

  factory VisitorResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VisitorResponseToJson(this);
}
