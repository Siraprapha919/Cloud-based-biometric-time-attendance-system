import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_response.dart';


part 'deviceAll_response.g.dart';
@JsonSerializable()
class DeviceAllResponse extends BaseResponse{
  List deviceAll;
  DeviceAllResponse(String respCode, String respDesc, String reqRefNo, String respRefNo,this.deviceAll) : super(respCode, respDesc, reqRefNo, respRefNo);
  factory DeviceAllResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceAllResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceAllResponseToJson(this);


}