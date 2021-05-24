import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';

part 'registration_request.g.dart';

@JsonSerializable()
class RegisterRequest extends BaseRequest {
  String firstname;
  String lastname;
  String mobile;
  String role;
  String email;
  String password;
  String img64;

  RegisterRequest(
      {this.firstname,
      this.lastname,
      this.mobile,
      this.role,
      this.email,
      this.password,
      this.img64,
      String reqRefNo})
      : super(reqRefNo);

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
