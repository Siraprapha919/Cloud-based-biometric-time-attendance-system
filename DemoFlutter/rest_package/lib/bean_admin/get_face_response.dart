import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_response.dart';
part 'get_face_response.g.dart';
@JsonSerializable()
class GetFaceResponse extends BaseResponse{
  List model;
  GetFaceResponse(String respCode, String respDesc, String reqRefNo, String respRefNo,this.model) : super(respCode, respDesc, reqRefNo, respRefNo);
  factory GetFaceResponse.fromJson(Map<String, dynamic> json) =>
      _$GetFaceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetFaceResponseToJson(this);
}