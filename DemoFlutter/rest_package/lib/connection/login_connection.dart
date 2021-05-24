import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:rest_package/bean_user/login_request.dart';
import 'package:rest_package/bean_user/logout_request.dart';
import 'package:rest_package/connection/abstract_connection.dart';
import 'package:rest_package/constant/header_constant.dart';
import 'package:rest_package/generator/x_signature.dart';

class LoginConnection extends AbstractConnection {
  LoginConnection(String url, String port) : super(url, port);
  Future<http.Response> login(LoginRequest request) {
    final endpoint = "cbbta-rest/user/login";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),
    });
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }

  Future<http.Response> logout(LogoutRequest request, String token) {
    final endpoint = "cbbta-rest/user/logout";
    final url = includeEndpoint(endpoint);
    final requestJson = jsonEncode(request.toJson());
    print(requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),
      HeaderConstant.xToken: token
    });
    print(url);
    return http.post(url, headers: headerMap, body: requestJson);
  }
}
