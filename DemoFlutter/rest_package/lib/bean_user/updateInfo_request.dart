import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';
part 'updateInfo_request.g.dart';

@JsonSerializable()
class UpdateInfoRequest extends BaseRequest{
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

  UpdateInfoRequest( this.recId,
  this.employeeNo,
  this.fname,
  this.lname,
  this.image,
  this.mobileNo,
  this.role,
  this.email,
  this.faceRegisStatus,
  this.faceStatus,String reqRefNo) : super(reqRefNo);
  factory UpdateInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateInfoRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateInfoRequestToJson(this);


}