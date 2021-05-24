import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_response.dart';
part 'config_response.g.dart';
@JsonSerializable()
class ConfigResponse extends BaseResponse{
  ConfigResponse(String respCode, String respDesc, String reqRefNo, String respRefNo) : super(respCode, respDesc, reqRefNo, respRefNo);
  factory ConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfigResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigResponseToJson(this);
}