

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';
part 'logout_request.g.dart';

@JsonSerializable()
class LogoutRequest extends BaseRequest{
  LogoutRequest(String reqRefNo) : super(reqRefNo);

factory LogoutRequest.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LogoutRequestToJson(this);
}