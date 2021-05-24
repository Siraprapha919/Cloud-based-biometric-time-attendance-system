import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';
part 'visitor_request.g.dart';
@JsonSerializable()
class VisitorRequest extends BaseRequest {
  VisitorRequest(String reqRefNo) : super(reqRefNo);
  factory VisitorRequest.fromJson(Map<String, dynamic> json) =>
      _$VisitorRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VisitorRequestToJson(this);
}
