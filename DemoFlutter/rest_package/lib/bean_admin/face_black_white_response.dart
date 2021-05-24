import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_response.dart';
part 'face_black_white_response.g.dart';

@JsonSerializable()
class FaceBlackWhiteResponse extends BaseResponse {
  FaceBlackWhiteResponse(
      String respCode, String respDesc, String reqRefNo, String respRefNo)
      : super(respCode, respDesc, reqRefNo, respRefNo);
  factory FaceBlackWhiteResponse.fromJson(Map<String, dynamic> json) =>
      _$FaceBlackWhiteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FaceBlackWhiteResponseToJson(this);
}
