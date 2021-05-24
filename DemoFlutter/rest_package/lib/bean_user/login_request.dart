import 'package:json_annotation/json_annotation.dart';

import 'base_request.dart';


part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest extends BaseRequest {
  String mobileNo;
  String password;

  LoginRequest(
    this.mobileNo, 
    this.password, 
    String reqRefNo) : super(reqRefNo);
  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
