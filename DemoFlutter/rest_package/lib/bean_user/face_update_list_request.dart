import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';
part 'face_update_list_request.g.dart';
@JsonSerializable()
class FaceUpdateListRequest extends BaseRequest{
  FaceUpdateListRequest(String reqRefNo) : super(reqRefNo);
  factory FaceUpdateListRequest.fromJson(Map<String, dynamic> json) =>
      _$FaceUpdateListRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FaceUpdateListRequestToJson(this);

}