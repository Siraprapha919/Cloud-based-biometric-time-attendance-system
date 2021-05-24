import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:rest_package/bean_admin/category_request.dart';
import 'package:rest_package/bean_admin/deviceAll_request.dart';
import 'package:rest_package/bean_admin/device_delete_request.dart';
import 'package:rest_package/bean_admin/device_register_request.dart';
import 'package:rest_package/bean_admin/device_update_request.dart';
import 'package:rest_package/bean_user/base_request.dart';
import 'package:rest_package/connection/abstract_connection.dart';
import 'package:rest_package/constant/header_constant.dart';
import 'package:rest_package/generator/x_signature.dart';

class DeviceConnection extends AbstractConnection{
  DeviceConnection(String url, String port) : super(url, port);
  Future<http.Response> category(CategoryRequest request,String token) {
    final endpoint = "cbbta-rest/device/category";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),HeaderConstant.xToken:token
    });
    print(requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }

  Future<http.Response> categoryAll(CategoryRequest request,String token) {
    final endpoint = "cbbta-rest/device/category/all";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),HeaderConstant.xToken:token
    });
    print(requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }

  Future<http.Response> deviceRegister(DeviceRegisterRequest request,String token) {
    final endpoint = "cbbta-rest/device/register";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),HeaderConstant.xToken:token
    });
    print(requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }

  Future<http.Response> deviceAll(DeviceAllRequest request,String token) {
    final endpoint = "cbbta-rest/device/deviceAll";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),HeaderConstant.xToken:token
    });
    print(requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }

  Future<http.Response> deviceDelete(DeviceDeleteRequest request,String token) {
    final endpoint = "cbbta-rest/device/delete";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),HeaderConstant.xToken:token
    });
    print(requestJson);

    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }

  Future<http.Response> deviceUpdate(DeviceUpdateRequest request,String token) {
    final endpoint = "cbbta-rest/device/update";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),HeaderConstant.xToken:token
    });
    print(requestJson);
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }
}