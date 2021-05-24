import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_response.dart';

part 'device_delete_response.g.dart';
@JsonSerializable()
class DeviceDeleteResponse extends BaseResponse{
  DeviceDeleteResponse(String respCode, String respDesc, String reqRefNo, String respRefNo) : super(respCode, respDesc, reqRefNo, respRefNo);
  factory DeviceDeleteResponse.fromJson(Map<String, dynamic> json) => _$DeviceDeleteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceDeleteResponseToJson(this);
}