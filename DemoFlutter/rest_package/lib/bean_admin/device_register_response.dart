import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_response.dart';
part 'device_register_response.g.dart';
@JsonSerializable()
class DeviceRegisterResponse extends BaseResponse{
  DeviceRegisterResponse(String respCode, String respDesc, String reqRefNo, String respRefNo) : super(respCode, respDesc, reqRefNo, respRefNo);
  factory DeviceRegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceRegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceRegisterResponseToJson(this);
}