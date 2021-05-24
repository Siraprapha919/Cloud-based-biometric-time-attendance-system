import 'package:json_annotation/json_annotation.dart';
import 'base_request.dart';
part 'faceExtraction_request.g.dart';
@JsonSerializable()
class FaceExtractionRequest extends BaseRequest {
  String userid;
  String username;
  String status;
  String image;

  FaceExtractionRequest(
      {
      this.userid,
      this.username,
      this.status,
      this.image,
      String reqRefNo})
      : super(reqRefNo);

  factory FaceExtractionRequest.fromJson(Map<String, dynamic> json) =>
      _$FaceExtractionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FaceExtractionRequestToJson(this);
}
