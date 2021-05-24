import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

part 'updateInfo_response.g.dart';
@JsonSerializable()
class UpdateInfoResponse extends BaseResponse{
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

  UpdateInfoResponse( this.recId,
  this.employeeNo,
  this.fname,
  this.lname,
  this.image,
  this.mobileNo,
  this.role,
  this.email,
  this.faceRegisStatus,
  this.faceStatus,String respCode, String respDesc, String reqRefNo, String respRefNo) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory UpdateInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateInfoResponseToJson(this);

}