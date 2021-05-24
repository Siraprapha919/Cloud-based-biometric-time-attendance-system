import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_response.dart';
import 'package:rest_package/model/categoryModel.dart';
part 'category_response.g.dart';
@JsonSerializable()
class CategoryResponse extends BaseResponse{
  List category;
  CategoryResponse(String respCode, String respDesc, String reqRefNo, String respRefNo,this.category) : super(respCode, respDesc, reqRefNo, respRefNo);
  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);

}