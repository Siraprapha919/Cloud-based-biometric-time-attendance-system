import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';
part 'get_face_request.g.dart';
@JsonSerializable()
class GetFaceRequest extends BaseRequest{
  GetFaceRequest(String reqRefNo) : super(reqRefNo);
  factory GetFaceRequest.fromJson(Map<String, dynamic> json) => _$GetFaceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetFaceRequestToJson(this);
}