import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';

part 'device_update_request.g.dart';
@JsonSerializable()
class DeviceUpdateRequest extends BaseRequest{
  var rec_id;
  String msCategory;
  String code;
  String name;

  DeviceUpdateRequest(this.rec_id,this.msCategory,this.code,this.name,String reqRefNo) : super(reqRefNo);

  factory DeviceUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceUpdateRequestToJson(this);
}