import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';
part 'category_request.g.dart';
@JsonSerializable()
class CategoryRequest extends BaseRequest{
  CategoryRequest(String reqRefNo) : super(reqRefNo);
  factory CategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$CategoryRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryRequestToJson(this);

}