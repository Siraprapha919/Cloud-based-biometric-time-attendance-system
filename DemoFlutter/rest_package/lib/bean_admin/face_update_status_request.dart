import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';
part 'face_update_status_request.g.dart';
@JsonSerializable()
class FaceUpdateStatusRequest extends BaseRequest{
  String id;
  String image;
  String statusExtraction;

  FaceUpdateStatusRequest(this.id,this.image,this.statusExtraction,String reqRefNo) : super(reqRefNo);

  factory FaceUpdateStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$FaceUpdateStatusRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FaceUpdateStatusRequestToJson(this);
}