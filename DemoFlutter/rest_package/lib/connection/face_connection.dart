import 'dart:convert';

import 'package:rest_package/bean_admin/face_black_white_request.dart';
import 'package:rest_package/bean_admin/face_update_status_request.dart';
import 'package:rest_package/bean_user/config_request.dart';
import 'package:rest_package/bean_user/faceExtraction_request.dart';
import 'package:rest_package/bean_user/face_update_list_request.dart';
import 'package:rest_package/bean_user/face_update_request.dart';
import 'package:rest_package/bean_user/info_visitor_request.dart';
import 'package:rest_package/connection/abstract_connection.dart';
import 'package:http/http.dart' as http;
import 'package:rest_package/constant/header_constant.dart';
import 'package:rest_package/generator/x_signature.dart';

class FaceExtractionConnection extends AbstractConnection {
  FaceExtractionConnection(String url, String port) : super(url, port);
  //, String token
  Future<http.Response> faceExtraction(
      FaceExtractionRequest request, String token) {
    final endpoint = "cbbta-rest/user/face_extraction";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    //  HeaderConstant.xToken: token
    headerMap.addAll({
      HeaderConstant.xToken: token,
      HeaderConstant.xSignature: XSignature().generate()
    });
    print("FaceExtraction Connection:" + token);
    print("requestJson:" + requestJson);
    return http.post(url, headers: headerMap, body: requestJson);
  }
//face_register_request
  Future<http.Response> faceRegisterRequest(FaceExtractionRequest request, String token) {
    final endpoint = "cbbta-rest/user/face_register_request";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    //  HeaderConstant.xToken: token
    headerMap.addAll({
      HeaderConstant.xToken: token,
      HeaderConstant.xSignature: XSignature().generate()
    });
    print("FaceExtraction Connection:" + token);
    print("requestJson:" + requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }
  Future<http.Response> faceUpdate(FaceExtractionRequest request, String token) {
    final endpoint = "cbbta-rest/user/face_update_request";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    //  HeaderConstant.xToken: token
    headerMap.addAll({
      HeaderConstant.xToken: token,
      HeaderConstant.xSignature: XSignature().generate()
    });
    print("FaceExtraction Connection:" + token);
    print("requestJson:" + requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }

  Future<http.Response> getFaceUpdate(FaceUpdateListRequest request, String token) {
    final endpoint = "cbbta-rest/user/faceupdate_list";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    //  HeaderConstant.xToken: token
    headerMap.addAll({
      HeaderConstant.xToken: token,
      HeaderConstant.xSignature: XSignature().generate()
    });
    print("FaceExtraction Connection:" + token);
    print("requestJson:" + requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }

  Future<http.Response> getFaceUpdateDeclined(FaceUpdateStatusRequest request) {
    final endpoint = "cbbta-rest/user/status_extraction";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    //  HeaderConstant.xToken: token
    headerMap.addAll({

      HeaderConstant.xSignature: XSignature().generate()
    });
    print("FaceExtraction Connection:");
    print("requestJson:" + requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }

  Future<http.Response> blackwhite(
      FaceBlackWhiteRequest request, String token) {
    final endpoint = "cbbta-rest/user/accessibility";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    //  HeaderConstant.xToken: token
    headerMap.addAll({
      HeaderConstant.xToken: token,
      HeaderConstant.xSignature: XSignature().generate()
    });
    print("FaceExtraction Connection:" + token);
    print("requestJson:" + requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }

  Future<http.Response> imageVisitor(
      InfoVisitorRequest request, String token) {
    final endpoint = "cbbta-rest/user/visitor_image";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    //  HeaderConstant.xToken: token
    headerMap.addAll({
      HeaderConstant.xToken: token,
      HeaderConstant.xSignature: XSignature().generate()
    });
    print("FaceExtraction Connection:" + token);
    print("requestJson:" + requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }
  Future<http.Response> config(
      ConfigRequest request, String token) {
    final endpoint = "cbbta-rest/user/config";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    //  HeaderConstant.xToken: token
    headerMap.addAll({
      HeaderConstant.xToken: token,
      HeaderConstant.xSignature: XSignature().generate()
    });
    print("FaceExtraction Connection:" + token);
    print(requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }
}
