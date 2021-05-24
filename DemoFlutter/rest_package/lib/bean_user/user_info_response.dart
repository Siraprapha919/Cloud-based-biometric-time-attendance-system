import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_response.dart';
part 'user_info_response.g.dart';

@JsonSerializable()
class UserInfoResponse extends BaseResponse {
  var recId;
  String employeeNo;
  String fname;
  String lname;
  String image;
  String mobileNo;
  String role;
  String email;
  String faceRegisStatus;
  String faceStatus;
  UserInfoResponse(
      this.recId,
      this.employeeNo,
      this.fname,
      this.lname,
      this.image,
      this.mobileNo,
      this.role,
      this.email,
      this.faceRegisStatus,
      this.faceStatus,
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo)
      : super(respCode, respDesc, reqRefNo, respRefNo);
  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);
}
