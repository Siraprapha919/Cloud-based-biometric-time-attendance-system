import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';
import 'package:rest_package/bean_user/base_response.dart';
part 'face_update_status_response.g.dart';
@JsonSerializable()
class FaceUpdateStatusResponse extends BaseResponse{
  FaceUpdateStatusResponse(String respCode, String respDesc, String reqRefNo, String respRefNo) : super(respCode, respDesc, reqRefNo, respRefNo);
  factory FaceUpdateStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$FaceUpdateStatusResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FaceUpdateStatusResponseToJson(this);
}