import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';
part 'face_update_request.g.dart';

@JsonSerializable()
class FaceUpdateRequest extends BaseRequest{
  String id;
  String image;

  FaceUpdateRequest(this.id,this.image,String reqRefNo) : super(reqRefNo);
  factory FaceUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$FaceUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FaceUpdateRequestToJson(this);
}