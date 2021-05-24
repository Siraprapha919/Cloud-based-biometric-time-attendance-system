import 'package:http/http.dart';

abstract class AbstractConnection {
  String urlPath;

  AbstractConnection(String url, String port) {
    this.urlPath = "http://$url:$port/";
  }

  String includeEndpoint(String endpoint) {
    return urlPath + endpoint;
  }
}
