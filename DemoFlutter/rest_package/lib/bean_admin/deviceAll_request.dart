import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';

part 'deviceAll_request.g.dart';
@JsonSerializable()
class DeviceAllRequest extends BaseRequest{
  DeviceAllRequest(String reqRefNo) : super(reqRefNo);
  factory DeviceAllRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceAllRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceAllRequestToJson(this);
}