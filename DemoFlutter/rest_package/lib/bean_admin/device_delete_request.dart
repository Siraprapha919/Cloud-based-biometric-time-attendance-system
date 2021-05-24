import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';
part 'device_delete_request.g.dart';
@JsonSerializable()
class DeviceDeleteRequest extends BaseRequest{
  String deviceCode;
  String loginNameStaff;

  DeviceDeleteRequest(this.deviceCode,this.loginNameStaff,String reqRefNo) : super(reqRefNo);
  factory DeviceDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceDeleteRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceDeleteRequestToJson(this);
}