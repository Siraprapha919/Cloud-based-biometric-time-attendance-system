import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';
part 'face_black_white_request.g.dart';

@JsonSerializable()
class FaceBlackWhiteRequest extends BaseRequest {
  String id;
  String status;

  FaceBlackWhiteRequest(this.id, this.status, reqRefNo) : super(reqRefNo);
  factory FaceBlackWhiteRequest.fromJson(Map<String, dynamic> json) =>
      _$FaceBlackWhiteRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FaceBlackWhiteRequestToJson(this);
}
