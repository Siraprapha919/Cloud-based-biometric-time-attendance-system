import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';

part 'getInfo_request.g.dart';

@JsonSerializable()
class GetInfoRequest extends BaseRequest {
  String id;
  String mobileNo;

  GetInfoRequest(
    this.id,
    this.mobileNo,
    String reqRefNo,
  ) : super(reqRefNo);
  factory GetInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$GetInfoRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetInfoRequestToJson(this);
}
