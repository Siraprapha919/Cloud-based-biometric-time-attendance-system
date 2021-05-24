import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';
import 'package:rest_package/bean_user/base_response.dart';
part 'getInfo_response.g.dart';

@JsonSerializable()
class GetInfoResponse extends BaseResponse {
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

  GetInfoResponse(
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
  factory GetInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$GetInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetInfoResponseToJson(this);
}
