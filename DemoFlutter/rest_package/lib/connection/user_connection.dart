import 'dart:convert';

import 'package:rest_package/bean_admin/get_face_request.dart';
import 'package:rest_package/bean_admin/visitor_request.dart';
import 'package:rest_package/bean_user/leaveReq_request.dart';
import 'package:rest_package/bean_user/position_request.dart';
import 'package:rest_package/bean_user/registration_request.dart';
import 'package:rest_package/bean_user/updateInfo_request.dart';
import 'package:rest_package/bean_user/user_info_request.dart';
import 'package:rest_package/connection/abstract_connection.dart';
import 'package:http/http.dart' as http;
import 'package:rest_package/constant/header_constant.dart';
import 'package:rest_package/generator/x_signature.dart';

class UserConnection extends AbstractConnection {
  UserConnection(String url, String port) : super(url, port);

  Future<http.Response> register(RegisterRequest request) {
    final endpoint = "cbbta-rest/user/register/info";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),
    });
    print(requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }

  Future<http.Response> getFace(GetFaceRequest request, String token) {
    final endpoint = "cbbta-rest/user/get_user";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),
      HeaderConstant.xToken: token
    });
    print(requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }

  Future<http.Response> getVisitor(VisitorRequest request, String token) {
    final endpoint = "cbbta-rest/user/attendance";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),
      HeaderConstant.xToken: token
    });
    print(requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }

  Future<http.Response> getInfo(UserInfoRequest request, String token) {
    final endpoint = "cbbta-rest/user/user_info";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),
      HeaderConstant.xToken: token
    });
    print(requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }
//request_staff_info

  Future<http.Response> getRequestStaffInfo(UserInfoRequest request, String token) {
    final endpoint = "cbbta-rest/user/request_staff_info";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),
      HeaderConstant.xToken: token
    });
    print(requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }
  Future<http.Response> getStaffInfo(UserInfoRequest request, String token) {
    final endpoint = "cbbta-rest/user/staff_info";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),
      HeaderConstant.xToken: token
    });
    print(requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }

  Future<http.Response> deleteUser(UserInfoRequest request, String token) {
    final endpoint = "cbbta-rest/user/user_delete";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),
      HeaderConstant.xToken: token
    });
    print(requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }
  Future<http.Response> updateInfo(UpdateInfoRequest request, String token) {
    final endpoint = "cbbta-rest/user/update_info";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),
      HeaderConstant.xToken: token
    });
    print(requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }
  //update_staff
  Future<http.Response> updateStaffInfo(UpdateInfoRequest request, String token) {
    final endpoint = "cbbta-rest/user/update_staff";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),
      HeaderConstant.xToken: token
    });
    print(requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }
  Future<http.Response> position(PositionRequest request) {
    final endpoint = "cbbta-rest/user/position";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate()
    });
    print(requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }

}
