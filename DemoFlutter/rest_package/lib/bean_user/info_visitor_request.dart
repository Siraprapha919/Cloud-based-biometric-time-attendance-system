import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';
import 'package:rest_package/bean_user/base_response.dart';
part 'info_visitor_request.g.dart';

@JsonSerializable()
class InfoVisitorRequest extends BaseRequest{
  String id;
  String username;
  InfoVisitorRequest(this.id,this.username,String reqRefNo) : super(reqRefNo);
  factory InfoVisitorRequest.fromJson(Map<String, dynamic> json) =>
      _$InfoVisitorRequestFromJson(json);
  Map<String, dynamic> toJson() => _$InfoVisitorRequestToJson(this);
}