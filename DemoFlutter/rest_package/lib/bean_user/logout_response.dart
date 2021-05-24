import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_response.dart';

part 'logout_response.g.dart';

@JsonSerializable()
class LogoutResponse extends BaseResponse {
 
  LogoutResponse(String respCode, String respDesc, String reqRefNo, String respRefNo) : super(respCode, respDesc, reqRefNo, respRefNo);
  factory LogoutResponse.fromJson(Map<String, dynamic> json) =>
      _$LogoutResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LogoutResponseToJson(this);
}
