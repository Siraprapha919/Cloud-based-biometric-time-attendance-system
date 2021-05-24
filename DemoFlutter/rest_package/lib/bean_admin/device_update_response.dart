import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_response.dart';

part 'device_update_response.g.dart';
@JsonSerializable()
class DeviceUpdateResponse extends BaseResponse{
  DeviceUpdateResponse(String respCode, String respDesc, String reqRefNo, String respRefNo) : super(respCode, respDesc, reqRefNo, respRefNo);
  factory DeviceUpdateResponse.fromJson(Map<String, dynamic> json) => _$DeviceUpdateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceUpdateResponseToJson(this);
}