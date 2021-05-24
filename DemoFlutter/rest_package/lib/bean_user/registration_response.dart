import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_response.dart';

part 'registration_response.g.dart';
 @JsonSerializable()
class RegisterResponse extends BaseResponse{
  RegisterResponse(String respCode, String respDesc, String reqRefNo, String respRefNo) : super(respCode, respDesc, reqRefNo, respRefNo);
  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}