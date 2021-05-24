import 'package:json_annotation/json_annotation.dart';


import 'base_response.dart';
part 'faceExtraction_response.g.dart';

@JsonSerializable()
class FaceExtractionResponse extends BaseResponse{
  FaceExtractionResponse(String respCode, String respDesc, String reqRefNo, String respRefNo) : super(respCode, respDesc, reqRefNo, respRefNo);
  factory FaceExtractionResponse.fromJson(Map<String, dynamic> json) =>
      _$FaceExtractionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FaceExtractionResponseToJson(this);

  
}