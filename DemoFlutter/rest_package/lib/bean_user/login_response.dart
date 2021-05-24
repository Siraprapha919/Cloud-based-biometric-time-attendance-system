import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_response.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends BaseResponse {
  String customerNo;
  String token;
  String mobileNo;
  String level;
  
  LoginResponse(this.customerNo, this.token, this.mobileNo,this.level, String respCode,
      String respDesc, String reqRefNo, String respRefNo)
      : super(respCode, respDesc, reqRefNo, respRefNo);
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
