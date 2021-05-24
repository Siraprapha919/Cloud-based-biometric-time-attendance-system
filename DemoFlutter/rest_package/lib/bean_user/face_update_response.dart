import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_response.dart';
part 'face_update_response.g.dart';

@JsonSerializable()
class FaceUpdateResponse extends BaseResponse{
  FaceUpdateResponse(String respCode, String respDesc, String reqRefNo, String respRefNo) : super(respCode, respDesc, reqRefNo, respRefNo);
  factory FaceUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$FaceUpdateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FaceUpdateResponseToJson(this);
}