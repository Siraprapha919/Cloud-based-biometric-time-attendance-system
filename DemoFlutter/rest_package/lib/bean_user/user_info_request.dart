import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';
part 'user_info_request.g.dart';

@JsonSerializable()
class UserInfoRequest extends BaseRequest {
  String id;
  String mobileNo;
  UserInfoRequest(this.id,this.mobileNo,String reqRefNo) : super(reqRefNo);
  factory UserInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$UserInfoRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoRequestToJson(this);
}
