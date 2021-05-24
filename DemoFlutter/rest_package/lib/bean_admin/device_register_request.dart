import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';
part 'device_register_request.g.dart';
@JsonSerializable()
class DeviceRegisterRequest extends BaseRequest {
  String msCategory;
  // String msProvinceCode;
  // String msDistrictCode;
  // String msSubdistrictCode;
  // String address;
  String code;
  String name;
  // String license;

  DeviceRegisterRequest(
      this.msCategory,
      // this.msProvinceCode,
      // this.msDistrictCode,
      // this.msSubdistrictCode,
      // this.address,
      this.code,
      this.name,
      // this.license,
      String reqRefNo)
      : super(reqRefNo);
  factory DeviceRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceRegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceRegisterRequestToJson(this);
}
